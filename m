Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTF2UTR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTF2UTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:19:16 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:42598 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264869AbTF2UTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:19:09 -0400
Date: Sun, 29 Jun 2003 16:31:48 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <20030629200239.GI27348@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Message-id: <200306291631480200.023DA0C0@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <200306291445470220.01DC8D9F@smtp.comcast.net> <3EFF3FFA.60806@post.pl>
 <20030629194423.GE26258@mail.jlokier.co.uk>
 <20030629200239.GI27348@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 9:02 PM viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Sun, Jun 29, 2003 at 08:44:23PM +0100, Jamie Lokier wrote:
>> Leonard Milcin Jr. wrote:
>> > >Nrrrg.  Yeah, I've got 80 gig and only CDR's to back up to, and no
>money.
>> > >A CDR may read for me the day it's written, and then not work the next
>> > >day.  Still a risk.
>> >
>> > Say, why you would want to change filesystem type?
>>
>> I'd like to try reiser4 when it is available because I heard from Hans
>> that it is faster...
>>
>> Isn't that a good reason?
>
>Not really.  Never, ever, try a new code on live system.  Put together
>a test box and/or test disk.  Regardless of nature of code in question -
>if you want to test something, go for a dedicated test setup.

Umm, reiser4 isn't going to be released as stable until it's well tested.
I heard months ago that initial betas were out--BETAs, as in IT'S DONE--
and stability was predicted by June.  If the code has been thoroughly
tested, then it satisfies this basic security principle, and thus he just
wants to try it out to see how it works.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



