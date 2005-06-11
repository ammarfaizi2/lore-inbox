Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVFKPFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVFKPFt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 11:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVFKPFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 11:05:49 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:48794 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261723AbVFKPFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 11:05:34 -0400
Date: Sat, 11 Jun 2005 17:05:25 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Steve Lord <lord@xfs.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-ID: <20050611150525.GI17639@ojjektum.uhulinux.hu>
References: <42A99D9D.7080900@xfs.org> <20050610112515.691dcb6e.akpm@osdl.org> <20050611082642.GB17639@ojjektum.uhulinux.hu> <42AAE5C8.9060609@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AAE5C8.9060609@xfs.org>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 08:23:20AM -0500, Steve Lord wrote:
> I think this is not actually module loading itself, but a problem
> between the fork/exec/wait code in nash and the kernel.

I do not use nash, only bash, so this is not a nash-specific issue.


-- 
pozsy
