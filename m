Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268261AbTBYTMr>; Tue, 25 Feb 2003 14:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268262AbTBYTMr>; Tue, 25 Feb 2003 14:12:47 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:15212 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S268261AbTBYTMp>; Tue, 25 Feb 2003 14:12:45 -0500
Date: Tue, 25 Feb 2003 21:22:48 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, mikael.starvik@axis.com,
       linux-kernel@vger.kernel.org, tinglett@vnet.ibm.com
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-ID: <20030225192248.GG158866@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, mikael.starvik@axis.com,
	linux-kernel@vger.kernel.org, tinglett@vnet.ibm.com
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk> <20030225110704.GD159052@niksula.cs.hut.fi> <20030225113557.C9257@flint.arm.linux.org.uk> <20030225083811.797fbce6.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225083811.797fbce6.rddunlap@osdl.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 08:38:11AM -0800, you [Randy.Dunlap] wrote:
> 
> It's for people who are less organized than you are -- gosh, maybe even
> for Linux users.

It doesn't even have to be _you_ that didn't save the .config. Sometimes one
has to compile a kernel for a server someone else has been maintaining. You
may not know if and where the .config for the old kernel is. Or perhaps it's
a vendor kernel.

In such case it's pretty convenient to just cat /proc/config.


-- v --

v@iki.fi
