Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267110AbSK2R03>; Fri, 29 Nov 2002 12:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267115AbSK2R03>; Fri, 29 Nov 2002 12:26:29 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:41607 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267110AbSK2R02>;
	Fri, 29 Nov 2002 12:26:28 -0500
Date: Fri, 29 Nov 2002 17:31:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Sipos Ferenc <sferi@mail.tvnet.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: help loading modules with 2.5.50
Message-ID: <20021129173121.GD20166@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Sipos Ferenc <sferi@mail.tvnet.hu>, linux-kernel@vger.kernel.org
References: <1038588730.1161.2.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038588730.1161.2.camel@zeus.city.tvnet.hu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 05:52:10PM +0100, Sipos Ferenc wrote:
 > Hi!
 > 
 > how could automatic system module loading be made with the latest
 > kernel? with 2.4 kernels, everything works fine, with 2.5, I have
 > installed the modules, but there's no modules.dep file, and not even my
 > network card module is loaded. Should I install some additional
 > software? My modutils version is 2.4.21. Thx.

You need new module utils.
Go read http://www.codemonkey.org.uk/post-halloween-2.5.txt

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
