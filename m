Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTBOMvt>; Sat, 15 Feb 2003 07:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTBOMvs>; Sat, 15 Feb 2003 07:51:48 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:28558 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261908AbTBOMvr>; Sat, 15 Feb 2003 07:51:47 -0500
Date: Sat, 15 Feb 2003 13:42:08 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rusty Lynch <rusty@linux.co.intel.com>, Pavel Machek <pavel@ucw.cz>,
       lkml <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Daniel Pittman <daniel@rimspace.net>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030215134208.G629@nightmaster.csn.tu-chemnitz.de>
References: <1045106216.1089.16.camel@vmhack> <1045160506.1721.22.camel@vmhack> <20030213230408.GA121@elf.ucw.cz> <1045260726.1854.7.camel@irongate.swansea.linux.org.uk> <20030214213542.GH23589@atrey.karlin.mff.cuni.cz> <1045264651.13488.40.camel@vmhack> <1045274042.2961.4.camel@irongate.swansea.linux.org.uk> <20030215082707.GE13148@host109.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030215082707.GE13148@host109.fsmlabs.com>; from cort@fsmlabs.com on Sat, Feb 15, 2003 at 01:27:07AM -0700
X-Spam-Score: -2.5 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18k1wr-0005xP-00*fLscJKNEMd2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Feb 15, 2003 at 01:27:07AM -0700, Cort Dougan wrote:
> Just to make sure no-one is happy except physicists, I suggest Kelvin.  I
> also suggest we spell disk/disc as "disck".

I suggest leaving out the "s" also, to keep the string length
constant, reduce kernel bloat and adding more fun to the live of
sysadmins.

Regards

Ingo Oeser ;-)
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
