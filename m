Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbUJ0DLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUJ0DLu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUJ0DLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:11:50 -0400
Received: from smtp.dei.uc.pt ([193.137.203.228]:29582 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261608AbUJ0DLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:11:47 -0400
Date: Wed, 27 Oct 2004 04:05:15 +0100 (WEST)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Ed Tomlinson <edt@aei.ca>
cc: Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
In-Reply-To: <200410261719.56474.edt@aei.ca>
Message-ID: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt>
References: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin> <200410261719.56474.edt@aei.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 26 Oct 2004, Ed Tomlinson wrote:

>> 2.4 tree is still the best solution for production.
>> 2.6 tree is great for gentoo users who like gcc consuming all CPU
>> (maxumum respect to gentoo but I prefer debian)
>
> The issue is that Linus _has_ changed the development model.  What we have
> now is more flexable and much more responsive to changes.  This does
> lead to stable releases that are not quite a stable as some of the previous
> stable series...  This is why I suggest a fix/security branch.  The idea being
> that after a month or so of fixes etc it will be a very stable kernel and it will
> not have slowed down development.

The sole existence of this discussion prooves that there's already the need of
a new step. But why trying to re-invent the wheel? Yes, relating to 2.6 we need
already a "very stable kernel" and a "not-slowed down development kernel". When
it happened in 2.4 2.5 was created. Isn't all this just the indication that we
need a 2.6 development like 2.4 is, and we need 2.7 to be created?

Mind Booster Noori

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFBfxBtmNlq8m+oD34RAtIwAKDjVsTaY8v5EB8jfYqGywlziU3WfACfZ6dH
XlhH9UPCngBYZ8R1mrHusSs=
=PxeH
-----END PGP SIGNATURE-----

