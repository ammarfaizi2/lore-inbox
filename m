Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310586AbSCGXFb>; Thu, 7 Mar 2002 18:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310585AbSCGXFJ>; Thu, 7 Mar 2002 18:05:09 -0500
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:16077 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S310586AbSCGXFG>; Thu, 7 Mar 2002 18:05:06 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [opensource] Re: Petition Against Official Endorsement of
In-Reply-To: <E16j6zb-00045d-00@the-village.bc.nu>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Fri, 08 Mar 2002 00:04:29 +0100
In-Reply-To: <E16j6zb-00045d-00@the-village.bc.nu> (Alan Cox's message of
 "Thu, 7 Mar 2002 23:08:11 +0000 (GMT)")
Message-ID: <871yewou82.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Using BitKeeper might break the way security issues are currently
>> handled by distributors of the GNU/Linux system, due to the open
>> logging feature.
>
> It simply means security updates have to be kept seperate from the bitkeeper
> maintained tree. We can handle that ok. It might mean the first Linus and
> Marcelo push into their tree is when the vendor updates go out but thats
> not a big problem to arrange

Keeping changes outside the CMS seems completely unnatural to me. ;-)

But maybe security-related changes are so much an exception that this
isn't a problem.

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
