Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTABRbU>; Thu, 2 Jan 2003 12:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbTABRbU>; Thu, 2 Jan 2003 12:31:20 -0500
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:3103 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S266246AbTABRbS>;
	Thu, 2 Jan 2003 12:31:18 -0500
From: <Hell.Surfers@cwctv.net>
To: josh@stack.nl, riel@conectiva.com.br, mark@justirc.net,
       linux-kernel@vger.kernel.org
Date: Thu, 2 Jan 2003 17:39:04 +0000
Subject: RE:Re: Why is Nvidia given GPL'd code to use in closed source drivers?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1041529144778"
Message-ID: <008da5838170213DTVMAIL1@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1041529144778
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

unfortuanately it requires patches, doesnt have a clear license, has bad coding style, the docs suck, im stuck to my eyeballs in cirrus code, and well, its not very clean, requires two input layer hacks, im writing docs that dont get completed cause the api, well, it sucks, aside from that, ive got a nice ggi acorn emulator...

Dean McEwan, If the drugs don't work, [sarcasm] take more...[/sarcasm].

On 	Thu, 2 Jan 2003 10:57:54 +0100 (CET) 	Jos Hulzink <josh@stack.nl> wrote:

--1041529144778
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Thu, 2 Jan 2003 09:58:52 +0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbTABJtd>; Thu, 2 Jan 2003 04:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTABJtd>; Thu, 2 Jan 2003 04:49:33 -0500
Received: from vaak.stack.nl ([131.155.140.140]:65040 "EHLO mailhost.stack.nl")
	by vger.kernel.org with ESMTP id <S261305AbTABJtc>;
	Thu, 2 Jan 2003 04:49:32 -0500
Received: by mailhost.stack.nl (Postfix, from userid 65534)
	id 111A360F03; Thu,  2 Jan 2003 10:58:01 +0100 (CET)
Received: from toad.stack.nl (toad.stack.nl [2001:610:1108:5010:202:b3ff:fe17:9e1a])
	by mailhost.stack.nl (Postfix) with ESMTP
	id 51E0760EC5; Thu,  2 Jan 2003 10:57:55 +0100 (CET)
Received: by toad.stack.nl (Postfix, from userid 971)
	id 01B2E961F; Thu,  2 Jan 2003 10:57:54 +0100 (CET)
Date: Thu, 2 Jan 2003 10:57:54 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mark Rutherford <mark@justirc.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <Pine.LNX.4.50L.0301011931240.2429-100000@imladris.surriel.com>
Message-ID: <20030102104612.V63864-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-2.4 required=8.0
	tests=EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Wed, 1 Jan 2003, Rik van Riel wrote:

> On Wed, 1 Jan 2003, Mark Rutherford wrote:
>
> > I would LOVE to see Nvidia open source,
> > We cannot force our ideas on a company, all they will do is turn and walk away.
> > We can show them our way, if they like it, good. if not, we tried.
>
> Nvidia is a smart company, otherwise they wouldn't be in
> business today.  I'm sure they'll switch to the GPL only
> once it will be in their advantage to do so and no sooner.
>
> When would it be an advantage for them ?
>
> The moment there is a GPL graphics library (at the right
> system level, of course) that's so good Nvidia won't be
> able to resist using that library could be such a moment.
>
> A new project for Hell.Surfers ? ;)

Mr Surfers has already showed up at the KGI development team, but as I
think his attitude doesn't quite fit in the team, I have not encouraged
him to help.

But yes, there is a GPL graphics kernel module / library (KGI & GGI) that
should run on linux and any BSD real soon now. The Radeon and Matrox
drivers are in place, already. The 3D accelleration framework is in place,
but the GGI GL implementation is not yet existing.

For those who want to take a look: the website (www.kgi-project.org) is
outdated, we lost contact with the maintainer :( Please take a look at the
kgi-wip project at sourceforge (CVS only) and at irc.openprojects.net #kgi

Jos

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1041529144778--


