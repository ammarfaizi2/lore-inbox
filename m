Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbTBHPJx>; Sat, 8 Feb 2003 10:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbTBHPJx>; Sat, 8 Feb 2003 10:09:53 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:64654 "EHLO
	yeti.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S267024AbTBHPJw>; Sat, 8 Feb 2003 10:09:52 -0500
Date: Sun, 9 Feb 2003 02:19:11 +1100
From: CaT <cat@zip.com.au>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59: loadavg shows 1.0 1.0 1.0 on idle system.(no APM enabled)
Message-ID: <20030208151911.GH940@zip.com.au>
References: <200302081611.49069.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302081611.49069.roy@karlsbakk.net>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2003 at 04:11:49PM +0100, Roy Sigurd Karlsbakk wrote:
> hi all
> 
> I've got this computer running 2.5.59, and after some time (dunno how
> long) it starts getting the load average stably at 1.0 while still
> being idle. check below for more info:

Any processes in D state? (ps aux | grep D)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to         kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

