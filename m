Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSIHRMx>; Sun, 8 Sep 2002 13:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSIHRMx>; Sun, 8 Sep 2002 13:12:53 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:3055 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317312AbSIHRMw>; Sun, 8 Sep 2002 13:12:52 -0400
Date: Sun, 8 Sep 2002 09:19:51 -0400
To: jmorris@intercode.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Performance issue in 2.5.32+
Message-ID: <20020908131951.GA25301@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> lmbench shows major changes in context switching latencies 
> on a dual celeron system 

Some lmbench tests vary a lot so I run it 25 times and 
average the results.  Some variations are only apparent on 
particular cpus (cache size differences, smp, etc).

The lmbench averaging script I use is:
http://home.earthlink.net/~rwhron/kernel/lmbsum

lmbench on a quad xeon and a bit on how to use lmbsum:
http://home.earthlink.net/~rwhron/kernel/bigbox.html#lmbench

Recent uniprocessor results:
http://home.earthlink.net/~rwhron/kernel/latest.html#lmbench

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

