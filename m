Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSEZJq6>; Sun, 26 May 2002 05:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315893AbSEZJq5>; Sun, 26 May 2002 05:46:57 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:48912 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315862AbSEZJq5>; Sun, 26 May 2002 05:46:57 -0400
Date: Sun, 26 May 2002 11:46:48 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Diego Calleja <DiegoCG@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.18, pdflush 100% cpu utilization
Message-ID: <20020526094648.GA15233@louise.pinerecords.com>
In-Reply-To: <20020525212512.7a14d1d9.DiegoCG@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.2.21 SMP
X-Architecture: sparc
X-Uptime: 3 days, 13:31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel Panic: pse required
                ^^^

$ cat /proc/cpuinfo
kala@kirsi:~$ cat /proc/cpuinfo| grep flags
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
                             ^^^

t.
