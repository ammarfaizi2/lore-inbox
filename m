Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSLQH6d>; Tue, 17 Dec 2002 02:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSLQH6c>; Tue, 17 Dec 2002 02:58:32 -0500
Received: from stingr.net ([212.193.32.15]:2571 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S264859AbSLQH6c>;
	Tue, 17 Dec 2002 02:58:32 -0500
Date: Tue, 17 Dec 2002 11:06:26 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Message-ID: <20021217080626.GE2496@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200212162049.16039.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200212162049.16039.tomlins@cam.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Ed Tomlinson:
> I am getting the above message in 2.5.51, 52, and 52+bk current.  
> Pci info follows:
> What else would help to debug this?  The drm error above is all I find in the logs...

If you mount devfs somewhere you also don't find misc/agpgart inside ?
:)))

And nothing about agp aperture in dmesg?

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
