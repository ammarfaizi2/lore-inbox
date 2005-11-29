Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVK2TaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVK2TaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVK2TaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:30:12 -0500
Received: from magic.adaptec.com ([216.52.22.17]:28631 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751351AbVK2TaK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:30:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Outlook Sux (Was: [2.6 patch] dpt_i2o fix for deadlock condition)
Date: Tue, 29 Nov 2005 14:30:09 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3DE12@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Outlook Sux (Was: [2.6 patch] dpt_i2o fix for deadlock condition)
Thread-Index: AcX1FjdnRvaPY8gbRYKwdDoudhVWlwAAkQDg
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Adrian Bunk" <bunk@stusta.de>,
       "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk [mailto:bunk@stusta.de] writes: 
>> There must still be a way to tell outlook to make the type something 
>> useful, rather than application/octet-stream.  maybe if the extension

>> was .patch.txt it would do something smarter.
> Patches in Attachments aren't nice, but better than corrupted patches.

:-)

Part of the problem is cut-n-paste engines on M$ and preservation of
content, the other part of the problem is the MUA making up it's own
rules on what constitutes a text document. It is not the MTA, sendmail
is blameless.

> It's unfortunate, but bitching on the people who are somehow forced to

> use crappy email clients is IMHO not a good idea.

We could always require that if a patch is done as an attachment, that
if it is smaller than 2K and/or at the submitters option, it also be
present as in-line content for code review convenience?

Thanks for that defense, I appreciate it. I am trapped in corporate
policy and MIS monitoring requirements. I have tried to make our MIS
department miserable over this issue, the sheer quantity of attempts to
mitigate is boggling and is still open. If I was paranoid, I'd almost
believe that M$ specifically decided to ignore RFC822 and all it's
children just to make it an impossible tool to use for submitting Linux
patches.

Now, if *someone* had an idea how I could configure Outlook 2002 to
properly produce in-line patches *that* would earn my eternal gratitude
(or a single stay at Hotel Salyzyn when visiting the Orlando Mouse House
;-> ). Outlook 2003 gets worse still by corrupting attachments (!) and I
thus reverted back to 2002.

Sincerely -- Mark Salyzyn
