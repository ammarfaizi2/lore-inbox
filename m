Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbSKOL2L>; Fri, 15 Nov 2002 06:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266122AbSKOL2L>; Fri, 15 Nov 2002 06:28:11 -0500
Received: from tapu.f00f.org ([66.60.186.129]:58306 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S266120AbSKOL2K>;
	Fri, 15 Nov 2002 06:28:10 -0500
Date: Fri, 15 Nov 2002 03:35:05 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Mikael Olenfalk <mikael@netgineers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-xfs eating filehandles when compiled with gcc 3.2
Message-ID: <20021115113505.GA27887@tapu.f00f.org>
References: <000a01c28c90$2d3c6ff0$0501a8c0@devnet.vodha>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000a01c28c90$2d3c6ff0$0501a8c0@devnet.vodha>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 11:17:18AM +0100, Mikael Olenfalk wrote:

> I have a Gentoo Linux 1.4 RC1 system, that ships with a GCC 3.2
> compiler and 2.4.19 with the XFS patches (and IMON btw).

Does it happen when you use gcc-2.95.4+ ?


  --cw
