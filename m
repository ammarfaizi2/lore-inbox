Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVDZNSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVDZNSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVDZNSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:18:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:162 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261508AbVDZNSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:18:21 -0400
Date: Tue, 26 Apr 2005 15:18:14 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, ian.pratt@cl.cam.ac.uk, akpm@osdl.org,
       ak@suse.de
Subject: Re: [PATCH 6/6][XEN][x86_64] use more usermode macro
Message-ID: <20050426131814.GC5098@wotan.suse.de>
References: <20050426113338.GF26614@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426113338.GF26614@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 01:33:38PM +0200, Vincent Hanquez wrote:
> Hi,
> 
> The following patch make use of the user_mode macro where it's possible.
> This is useful for Xen because it will need only to redefine only the macro
> to a hypervisor call. 
> 
> Please apply, or comments.

Thanks looks good.

-Andi
