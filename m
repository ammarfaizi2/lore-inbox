Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292968AbSB0Wzn>; Wed, 27 Feb 2002 17:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293022AbSB0WzE>; Wed, 27 Feb 2002 17:55:04 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:23696 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S293027AbSB0WyQ>; Wed, 27 Feb 2002 17:54:16 -0500
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Andreas Franck
In-Reply-To: <fa.c7mcedv.1a3esq4@ifi.uio.no>
Subject: Re: Linux 2.4.19pre1-ac1
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <5fe3.3c7d6393.7ac52@trespassersw.daria.co.uk>
Date: Wed, 27 Feb 2002 22:54:11 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <fa.c7mcedv.1a3esq4@ifi.uio.no>,
	Andreas Franck <afranck@gmx.de> writes:
AF> Hi Florin, hi Alan,
AF> 
>> With 19-pre1-ac1 on a reiserfs partition I cannot patch a kernel. Patch
>> fails with "Invalid cross-device link" or "Out of disk space".
AF> 
AF> I can reproduce this too on ext2, so this does not seem to be FS related. 

Likewise (reiserfs here). Numerous fuzz or outright patch failures
with 2.4.19-pre1-ac1.

