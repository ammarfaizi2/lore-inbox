Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278720AbRJXTLC>; Wed, 24 Oct 2001 15:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279567AbRJXTKx>; Wed, 24 Oct 2001 15:10:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37810 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S278720AbRJXTKq>;
	Wed, 24 Oct 2001 15:10:46 -0400
Date: Wed, 24 Oct 2001 13:22:16 -0500
From: EvilTypeGuy <eviltypeguy@qeradiant.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Simplify serverworks workaround.
Message-ID: <20011024132216.I15867@virtucon.warpcore.org>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011024185512.A6207@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011024185512.A6207@suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2001 at 06:55:12PM +0100, Dave Jones wrote:
> Linus, Richard,
>  Patch below makes the workaround for Serverworks LE chipsets
>  a little simpler, and also adds a printk to let people know
>  why they can't use Write-combining.

Do the serverworks HE chipsets have the same problem?

