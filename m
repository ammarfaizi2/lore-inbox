Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262724AbSJHM42>; Tue, 8 Oct 2002 08:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262819AbSJHM42>; Tue, 8 Oct 2002 08:56:28 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:25899 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S262724AbSJHM4Z>;
	Tue, 8 Oct 2002 08:56:25 -0400
From: <Hell.Surfers@cwctv.net>
To: jw@pegasys.ws, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 14:01:58 +0100
Subject: RE:Re: The end of embedded Linux?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1034082118740"
Message-ID: <0a5b347591208a2DTVMAIL4@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1034082118740
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

If its a personal project, use nothing, not even RMS would care[probably].

Cheers, Dean.

On 	Tue, 8 Oct 2002 04:27:19 -0700 	jw schultz <jw@pegasys.ws> wrote:

--1034082118740
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Tue, 8 Oct 2002 12:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262052AbSJHLVr>; Tue, 8 Oct 2002 07:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262064AbSJHLVq>; Tue, 8 Oct 2002 07:21:46 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:49677 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262052AbSJHLVm>; Tue, 8 Oct 2002 07:21:42 -0400
Received: from leto.pegasys.ws (leto.pegasys.ws [10.1.1.20])
	by vladimir.pegasys.ws (Mail Transfer Agent) with ESMTP id 7F6FDDF2C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2002 04:29:51 -0700 (PDT)
Received: from duncan.pegasys.ws (duncan.pegasys.ws [10.1.1.50])
	by leto.pegasys.ws (Mail Transfer Agent) with ESMTP id C7585188
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2002 04:27:21 -0700 (PDT)
Received: by duncan.pegasys.ws (Postfix on SuSE Linux 8.0 (i386), from userid 1001)
	id B0ABD4AF3; Tue,  8 Oct 2002 04:27:19 -0700 (PDT)
Date: Tue, 8 Oct 2002 04:27:19 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021008112719.GC6537@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <3DA1CF36.19659.13D4209@localhost> <3DA2BD70.14919.2C6951@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA2BD70.14919.2C6951@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Tue, Oct 08, 2002 at 11:11:44AM +0100, simon@baydel.com wrote:
> The UART and Interrupt controllers in question are built into a gate 
> array. I can't see how any external or parts from other vendors 
> would be compatible. To get the board to boot Linux I have to 
> modify the kernel and lilo. I understand that under the GPL rules I 
> would have to make this code available. I am willing to do this but I 
> don't see the point. 

The point is that is the license fee.  Under the BSD
license the fee is giving credit.  For Microsoft and other
closed-source/propietary licenses the fee is in money.
With the GPL the consideration (legal term under contract
law) or fee that you pay is to make the source of your
modifications and derivitave works available.
Most of the time that is a fairly inexpensive fee.

If you wish to negotiate a different fee all you have to do
is get every contributor to agree to a seperate license for
you.  You are free (libre) to try but i think it would be
cheaper to go elsewhere.

> There is also more specialized hardware for which I have written 
> modules. Although there appears to be some unwritten rule about 
> releasing objects, I believe that the GPL rules state that these 
> modules must conform to the GPL also, as they contain header 
> files. I cannot see how any module can not contain Linux headers 
> or headers derived from Linux headers if it is to be loaded on a 
> Linux kernel. 

Leave headers aside for the moment.  There is a tolerance
(barely) of binary modules distributed largely because they
suit the purposes of linux (world domination, haha).  Using binary
only modules that don't benefit that will draw the ire (if
not prosecution) of the community.

> These modules again drive gate array hardware for which nobody 
> else will ever have a compatible. Although I would dearly love to 
> use Linux as the platform for my project I feel I cannot release this 
> code under the GPL.

The fact that may be custom hardware that no-one else will
every have access to isn't relevant to the licence.  The
general concensus is that very few embedded projects are
really all that dependant on such specialized hardware.

> This is my dilemma and I am sure it is shared by others. For this 
> reason I cannot see how anything but an embedded PC with 
> applications or a perhaps a very simple hardware device could be 
> considered as an opportunity for  embedded Linux. 

It isn't much of a dilema.  It is just a simple choice you
have to make.  Do you create your own OS?  Or if you choose
to buy one, which license terms are best for you.

Of course you are free to use linux for prototyping and
product developement.  The publication requirements only
come into play when you distribute.  If you choose to use
linux to help develop your product and then distribute with
a different OS then linux has helped to enlarge the GGP
(Gross Global Product) and that is still good.

> I have based these thoughts on my experiences so far. If you feel I 
> have drawn an incorrect conclusion I would be grateful for your 
> input.

They may be correct conclusions for yourself.  Only you can
judge that.  I doubt that they are correct generalizations.

There are some things i would think about before rejecting
linux on such a basis.  Nothing prevents you from putting a
firmware layer underneath linux or putting a bit more
intelegence in your device and then providing a free driver
that can interface with it.  You may be able to put the
intellegence of your hardware control in a user-space
process with elevated priority.  You might look into
something like using the adeos nano-kernel to host linux and
the device controll software as seperate contexts with a
communications interface between them.  There are so many
ways to get linux and proprietary software and hardware to
talk to each other it seems silly to reject it just because
one of way bears license terms you don't like.

If you wish to use linux and contribute good.  If you wish
to go away that is your choice.  If you wish to whine, see
option two.  In either case good luck with your project.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1034082118740--


