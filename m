Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbTLFS1b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 13:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbTLFS1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 13:27:31 -0500
Received: from law9-f111.law9.hotmail.com ([64.4.9.111]:1038 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S265226AbTLFS1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 13:27:30 -0500
X-Originating-IP: [62.73.41.232]
X-Originating-Email: [tero1001@hotmail.com]
From: "Tero Knuutila" <tero1001@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
Date: Sat, 06 Dec 2003 20:27:29 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law9-F111RPjRRlH4zX000126ea@hotmail.com>
X-OriginalArrivalTime: 06 Dec 2003 18:27:29.0823 (UTC) FILETIME=[9B62D2F0:01C3BC26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

>Good. However, I'd still like to hear if ide-scsi.c works with the patch:
>it's deprecated and I don't actually encourage people to use it, but it
>would be interesting to hear whether it works for people..

I had to throw away one faulty cd-disk, and now my 2.6-test11 works!!
I did two things while having troubles: Applied Linus's patch and
tried John Bradford's tip to turn off pre-emptive kernel (in processor 
options).

I am currently in a process to put pre-emptive back to enabled so soon I can 
tell if it was the patch or the option change.

I'll be back in one hour. Thanks already for Your help, this test11 kernel 
is fast and goog, I LIKE it!!!

Rgds,

    Tero

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

