Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbUFRFjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUFRFjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 01:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUFRFjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 01:39:45 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42761 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263174AbUFRFjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 01:39:44 -0400
Date: Fri, 18 Jun 2004 07:34:55 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] save kernel version in .config file
Message-ID: <20040618053455.GF29808@alpha.home.local>
References: <20040617220651.0ceafa91.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617220651.0ceafa91.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 10:06:51PM -0700, Randy.Dunlap wrote:
> 
> Is this interesting to anyone besides me?
> Save kernel version info when writing .config file.

Very good idea Randy ! I've already used some wrong config picked out of 20,
and having a simple way to do a quick check is really an enhancement. BTW,
does KERNELRELEASE include the build number ? and could we include the
config date in the file too ?

Regards,
Willy

