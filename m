Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVBJEch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVBJEch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 23:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVBJEch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 23:32:37 -0500
Received: from orb.pobox.com ([207.8.226.5]:7064 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262018AbVBJEcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 23:32:36 -0500
Date: Wed, 9 Feb 2005 20:32:30 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.11-rc3-mm1
Message-ID: <20050210043230.GC7524@ip68-4-98-123.oc.oc.cox.net>
References: <20050204103350.241a907a.akpm@osdl.org> <Pine.LNX.4.61.0502090357060.7433@student.dei.uc.pt> <20050209201207.54c1f99a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209201207.54c1f99a.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 08:12:07PM -0800, Andrew Morton wrote:
> (I understand that it's only a "proof of concept" patch, but I thought I'd
> bitch anyway ;))
> 
> So.  I'll keep the patch as-is in -mm for now.  I've Cc'ed linux-acpi. 
> Perhaps the people there can absorb this and fix it up for real, please?

I forgot to mention, this patch is known to break Alt-SysRq-O on at
least some systems. See here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0501.3/0869.html

-Barry K. Nathan <barryn@pobox.com>
