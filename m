Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130967AbRAYXTz>; Thu, 25 Jan 2001 18:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130970AbRAYXTp>; Thu, 25 Jan 2001 18:19:45 -0500
Received: from austin.jhcloos.com ([206.224.83.202]:35594 "HELO
	austin.jhcloos.com") by vger.kernel.org with SMTP
	id <S130967AbRAYXTi>; Thu, 25 Jan 2001 18:19:38 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net>
	<200101251905.f0PJ5ZG216578@saturn.cs.uml.edu>
	<14960.31423.938042.486045@pizda.ninka.net>
	<20010125115214.D9992@draco.foogod.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20010125115214.D9992@draco.foogod.com>
Date: 25 Jan 2001 17:19:37 -0600
Message-ID: <m3itn3i5iu.fsf@austin.jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "alex" == alex  <alex@foogod.com> writes:

alex> I think the point of a test address is that this could
alex> conceivably affect more providers than just Hotmail, and it
alex> would be useful for people to be able to check to make sure
alex> their own provider isn't also ECN brain damaged ...

I have to agree with this.

Are there any well know sites using ECN we can test against?

Doesn't have to be a mail server, of course.  Maybe a web server with
auth lookups turned on?  or an ftp server supporting only non-passive
xfers.  An open squid.  Several possibilities exist for the general
case.  (Although for some who want to test a mail autoresponder may be
the only useable option....)

-JimC
-- 
James H. Cloos, Jr.  <http://jhcloos.com/public_key>     1024D/ED7DAEA6 
<cloos@jhcloos.com>  E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
