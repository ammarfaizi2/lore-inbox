Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319251AbSH2TBR>; Thu, 29 Aug 2002 15:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSH2TBR>; Thu, 29 Aug 2002 15:01:17 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:48826 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319251AbSH2TBP>; Thu, 29 Aug 2002 15:01:15 -0400
Date: Thu, 29 Aug 2002 21:05:33 +0200
To: linux-kernel@vger.kernel.org
Subject: Keyboard freezes on SIS630 based Clevo notebooks
Message-ID: <20020829190533.GA11223@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I own a SIS630 based notebook from Baycom (model name "Worldbook II"), which
indeed is a rebrand from a Clevo/Kapok model (normal model name 2700C).

I'm experiencing occasional, unreproducable keyboard lockups. No keyboard
input at all is accepted while the machine itself continues to work
properly (processes continue to write to stdout and I can login and 
continue to work through SSH). The freezes occur approx. at least once
a week and sometimes three times a day, so there's no real pattern behind
it.

A friend of mine owns the same model and the same problems occur; I also
found a website stating the same problems on it; so it's of general nature
and not specific to my hardware. I didn't find any information about these
freezes running Windows, so I guess it's Linux-kernel specific and not a sole
hardware issue.

The system freezed on all kinds of kernel, either 2.4 and 2.5, either
vanilla and heavily patched.

So, the big question: Which data would I need to collect on the next freeze
that would allow an experienced kernel hacker to track down the problem?

This nasty bug is the only thing in the way to a perfect Linux notebook,
everything else works just perfect.

TIA,
         Moritz
