Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTFTSWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTFTSWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:22:25 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:29232 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264088AbTFTSWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:22:22 -0400
Message-ID: <3EF353B9.6050303@myrealbox.com>
Date: Fri, 20 Jun 2003 14:34:33 -0400
From: Nicholas Wourms <nwourms@myrealbox.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 MultiZilla/v1.1.20
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Disconnect <kernel@gotontheinter.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] to "Disable Trackpad while typing" patch
References: <200306201818.40805.torsten.foertsch@gmx.net> <1056128080.17756.38.camel@slappy>
X-Enigmail-Version: 0.75.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disconnect wrote:
> Is this a patch against a patch (instead of against modified pc_keyb.c)
> or did the mailer just chew it up badly?
> 
>>Hash: SHA1
>>
>>see http://marc.theaimsgroup.com/?l=linux-kernel&m=105182586512456&w=2
>>
[SNIP]
>>
>>- --- drivers/char/pc_keyb.c.orig	2003-06-20 08:10:41.000000000 +0000
>>+++ drivers/char/pc_keyb.c	2003-06-20 15:45:01.000000000 +0000
>>@@ -18,6 +18,9 @@
>>  * notebooks with a PS/2 trackpad.
>>  * Hans-Georg Thien <1682-600@onlinehome.de> 2003-04-30.
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Hi,

Based on this hunk in the diff, I'd assume that it is a patch against 
the patch mentioned in that url.

Cheers,
Nicholas

