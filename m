Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261675AbSIXNse>; Tue, 24 Sep 2002 09:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261676AbSIXNse>; Tue, 24 Sep 2002 09:48:34 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:39334 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261675AbSIXNsc>;
	Tue, 24 Sep 2002 09:48:32 -0400
Date: Tue, 24 Sep 2002 14:57:22 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Petr Slansky <slansky@usa.net>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: hpt370 raid driver
Message-ID: <20020924135722.GA3026@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Petr Slansky <slansky@usa.net>, alan@redhat.com,
	linux-kernel@vger.kernel.org
References: <20020924132445Z261665-8740+289@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020924132445Z261665-8740+289@vger.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 02:29:54PM +0100, Petr Slansky wrote:
 > do you know that there is a source code of driver for HPT370 raid at the
 > manufacturer web?
 > 
 > http://www.highpoint-tech.com/370drivers_down.htm
 > http://www.highpoint-tech.com/hpt3xx-opensource-v13.tgz

 Highpoint have a strange concept of 'opensource'.

 (davej@halogen:davej)$ tar zxvf hpt3xx-opensource-v13.tgz 
 rules.mak
 Makefile
 hpt.c
 hptkern.h
 hptglb.h
 hpt.h
 hpt37x2lib.o
 readme.txt

 (davej@halogen:davej)$ ll hpt37x2lib.o 
 -rw-r--r--    1 davej    davej       63639 Apr  5 21:35 hpt37x2lib.o
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
