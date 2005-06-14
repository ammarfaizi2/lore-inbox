Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVFNU7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVFNU7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVFNU7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:59:38 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:21962 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261334AbVFNU7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:59:36 -0400
Date: Tue, 14 Jun 2005 22:59:33 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Prarit Bhargava <prarit@sgi.com>
Cc: Steve Lord <lord@xfs.org>, "K.R. Foley" <kr@cybsft.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-ID: <20050614205933.GC7082@ojjektum.uhulinux.hu>
References: <42AAE5C8.9060609@xfs.org> <20050611150525.GI17639@ojjektum.uhulinux.hu> <42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com> <42AF165E.1020702@xfs.org> <42AF2088.3090605@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AF2088.3090605@sgi.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 02:23:04PM -0400, Prarit Bhargava wrote:
> The second fix, and again you must do this if you're developing 2.6.12, is 
> to *update the mkinitrd package* which has a new version of /bin/sh.

This sounds insane to me. I am using bash in my initrd, does this mean 
that every shell and whatever has to be updated? Exactly what 
modifications has to be made?


-- 
pozsy
