Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbSJQRPO>; Thu, 17 Oct 2002 13:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261629AbSJQRPN>; Thu, 17 Oct 2002 13:15:13 -0400
Received: from ns.suse.de ([213.95.15.193]:46098 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261575AbSJQROo>;
	Thu, 17 Oct 2002 13:14:44 -0400
Date: Thu, 17 Oct 2002 19:20:41 +0200
From: Dave Jones <davej@suse.de>
To: Hiroshi Miura <miura@da-cha.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: NatSemi Geode improvement
Message-ID: <20021017192041.B17285@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Hiroshi Miura <miura@da-cha.org>, hpa@zytor.com,
	linux-kernel@vger.kernel.org, alan@redhat.com
References: <20021017171217.4749211782A@triton2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021017171217.4749211782A@triton2>; from miura@da-cha.org on Fri, Oct 18, 2002 at 02:12:17AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 02:12:17AM +0900, Hiroshi Miura wrote:

 > NatSemi Geode has a several feature to speed up,
 > but reset defalut value is set to slow side.
 > 
 > I make a patch to speed up Geode about 20-40%!!
 > the benchmark result is downloadable from http://www.da-cha.org/geode/geode_graph.sxc.
 > that is openoffice format.
 > 
 > I use this patch with 2.4.18, 2.4.19 in 4 month, I think it is stable enough.

Previously these tweaks were done in userspace with the set6x86 utility.
Is there any reason that these need to be done in the kernel apart from
convenience ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
