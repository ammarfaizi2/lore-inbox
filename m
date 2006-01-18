Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWARAnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWARAnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWARAnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:43:11 -0500
Received: from cabal.ca ([134.117.69.58]:19350 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S965007AbWARAnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:43:09 -0500
Date: Tue, 17 Jan 2006 19:41:56 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] [PATCH] Fix parisc build (flush_tlb_all_local)
Message-ID: <20060118004156.GI4049@quicksilver.road.mcmartin.ca>
References: <20060118002000.GA24835@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118002000.GA24835@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 03:20:00AM +0300, Alexey Dobriyan wrote:
> It's taking "void *" now.
>

You're the third person to say this. The fix was missed in the initial 
changeset. The fixed patch is already queued. 
