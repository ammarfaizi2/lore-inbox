Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287724AbSAADVs>; Mon, 31 Dec 2001 22:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287725AbSAADVi>; Mon, 31 Dec 2001 22:21:38 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:46490 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S287724AbSAADVX>; Mon, 31 Dec 2001 22:21:23 -0500
Date: Tue, 1 Jan 2002 03:23:35 +0000
From: Dave Jones <davej@suse.de>
To: ccroswhite@get2chip.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual athlon XP 1800 problems
Message-ID: <20020101032335.A11129@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, ccroswhite@get2chip.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C311B00.FFB58648@get2chip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C311B00.FFB58648@get2chip.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2001 at 06:12:16PM -0800, ccroswhite@get2chip.com wrote:
 > I am having problems with dual athlons and more than 512M RAM.
 > Here is the configuration:
 > Dual Athlon XP 1800
               ^^
 Not a valid SMP configuration. Some people are getting away with
 running XP's in SMP boxes, others aren't. And soon, it looks like
 no new XP's will run in SMP at all.

 Take one out/boot a UP kernel, and see if the problems go away.

 Dave.

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
