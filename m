Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317640AbSGJWJS>; Wed, 10 Jul 2002 18:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSGJWJS>; Wed, 10 Jul 2002 18:09:18 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:48014 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S317640AbSGJWJR>;
	Wed, 10 Jul 2002 18:09:17 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 10 Jul 2002 16:09:21 -0600
To: Thunder from the hill <thunder@ngforever.de>
Cc: Andrew Morton <akpm@zip.com.au>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
Message-ID: <20020710160921.H32168@host110.fsmlabs.com>
References: <3D2CA6E3.CB5BC420@zip.com.au> <Pine.LNX.4.44.0207101559460.5067-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207101559460.5067-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Wed, Jul 10, 2002 at 04:01:08PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, please do make it a config option.  10x interrupt overhead makes me
worry.  It lets users tailor the kernel to their expected load.
