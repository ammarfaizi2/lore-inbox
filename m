Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUBDOpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 09:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUBDOpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 09:45:18 -0500
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:31910 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262078AbUBDOpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 09:45:13 -0500
Message-ID: <40210578.6000504@mrc-bsu.cam.ac.uk>
Date: Wed, 04 Feb 2004 14:45:12 +0000
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Organization: MRC Biostatistics Unit
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.2 aka "Feisty Dunnart"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very nice.  But I see the name thing is really official now:

   2 alastair@gluck:~/linux-2.6> head Makefile
   VERSION = 2
   PATCHLEVEL = 6
   SUBLEVEL = 2
   EXTRAVERSION =
   NAME=Feisty Dunnart

Its own line in the Makefile, no less.  So, no doubt you're planning to 
actually _use_ this in some devious way?  Worrying indeed....

BTW, I did my first attempt at an ATAPI CD burn last night, on one of 
Feisty Dunnart's release candidates, and it was wildly successful.  I'm 
sure this isn't news, but it was great to see.

2.6 is looking great from here, no visible problems for me.

Cheers
Alastair

-- 
  \\ ........................................   www.mrc-bsu.cam.ac.uk
   \\  Alastair Stevens, SysAdmin Team       \       01223 330383
   //  MRC Biostatistics Unit, Cambridge UK   \.......................
  --
