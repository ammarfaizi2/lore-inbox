Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262758AbSITPAg>; Fri, 20 Sep 2002 11:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262759AbSITPAg>; Fri, 20 Sep 2002 11:00:36 -0400
Received: from angband.namesys.com ([212.16.7.85]:55974 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262758AbSITPAf>; Fri, 20 Sep 2002 11:00:35 -0400
Date: Fri, 20 Sep 2002 19:05:37 +0400
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org
Subject: Booting problems with dual p4 on i860 chipset with 2.4 and 2.5
Message-ID: <20020920190537.A11244@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   We have a problem with newly acquired dual p4 xeon (2.2Ghz, heperthreading
   blah blah) box built on i860 chipset (SuperMicro P4DC6+ motherboard).
   Whenever we try to boot 2.4 or 2,5 kernel in there it decompresses
   the kernel itself, states 'Ok, booting the kernel' and hangs.
   We already tested these versions 2.4.15, 2.4.20-pre7, 2.4.18 from SuSE 8.0,
   2.4.18 from RedHat 7.3 and latest RedHat beta (null), 2.5.36 (latest bk
   snapshot as of now). 
   I remember I saw something like we experience now being reported on lkml
   awhile back and 2.2 was able to boot in that case, so we tried 2.2.21
   and it worked to our surprise.
   We tried to install latest BIOS version available from MB manufacturer but
   that did not help.
   Unfortunatelly we are no longer able to find that mail with similar problems,
   so may be someone have any ideas on what to do to get 2.4 (and 2.5)
   up and runing on such a box?

   Thank you.

Bye,
    Oleg
