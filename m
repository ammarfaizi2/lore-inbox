Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVCSV3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVCSV3i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 16:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVCSV3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 16:29:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10167 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261832AbVCSV3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 16:29:34 -0500
Date: Sat, 19 Mar 2005 22:29:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Russell Miller <rmiller@duskglow.com>
Cc: erik.andren@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Suspend-to-disk woes
Message-ID: <20050319212922.GA1835@elf.ucw.cz>
References: <423B01A3.8090501@gmail.com> <20050319132612.GA1504@openzaurus.ucw.cz> <200503191220.35207.rmiller@duskglow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503191220.35207.rmiller@duskglow.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 19-03-05 12:20:35, Russell Miller wrote:
> On Saturday 19 March 2005 05:26, Pavel Machek wrote:
> 
> > Checking that would be hard, but you might want to provide patch to check
> > last-mounted dates of filesystems and panic if they changed.
> > 				Pavel
> 
> Then how would you fix it?  There'd also have to be a way to reset it, 

boot with "noresume", then mkswap.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
