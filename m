Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTCFPPx>; Thu, 6 Mar 2003 10:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTCFPPx>; Thu, 6 Mar 2003 10:15:53 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:25036 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S265637AbTCFPPx>; Thu, 6 Mar 2003 10:15:53 -0500
Date: Fri, 7 Mar 2003 02:26:16 +1100
From: CaT <cat@zip.com.au>
To: cpufreq@www.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.64 - cpu freq not turned on
Message-ID: <20030306152616.GB432@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a 2.5.x kernel that allowed me to use cpufreq with it but the
recent ones just give me this message:

cpufreq: Intel(R) SpeedStep(TM) for this chipset not (yet) available.

Now I know it worked before cos I noticed it and played about with the 8
speed steps I had available to me (and I thought I only had 2).

What information is needed about my chipset to make the code detect it
properly?

(not on cpufreq ml btw)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

