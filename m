Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVDRHwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVDRHwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 03:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVDRHwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 03:52:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30695 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261944AbVDRHwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 03:52:06 -0400
Date: Mon, 18 Apr 2005 09:51:02 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] drivers/char/random.c: #if 0 randomize_range
Message-ID: <20050418075101.GA21792@devserv.devel.redhat.com>
References: <20050417201537.GO3625@stusta.de> <20050417204034.GJ21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050417204034.GJ21897@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 01:40:34PM -0700, Matt Mackall wrote:
> On Sun, Apr 17, 2005 at 10:15:37PM +0200, Adrian Bunk wrote:
> > This patch #if 0's the unused global function randomize_range.
> >
> 
> This is presumably for future work in process randomization. Arjan,
> what's the status of this bit?

I'll start submitting more randomisation stuff once 2.6.12 gets out; however
I'm more than fine with the #if 0; I'll just remove the if 0's in those
patches when I start using this stuff.

