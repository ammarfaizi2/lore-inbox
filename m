Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUIVUst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUIVUst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUIVUss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:48:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38372 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267521AbUIVUss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:48:48 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm2
Date: Wed, 22 Sep 2004 16:48:30 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040922131210.6c08b94c.akpm@osdl.org>
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409221648.30234.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 22, 2004 4:12 pm, Andrew Morton wrote:
> - This kernel doesn't work on ia64 (instant reboot).  But neither does
>   2.6.9-rc2, nor current Linus -bk.  Is it just me?

I certainly hope so.  Current bk works on my 2p Altix, and iirc 2.6.9-rc2 
worked as well.  I'm trying 2.6.9-rc2-mm2 right now.  I haven't tried 
generic_defconfig yet either, maybe that's it?

Jesse
