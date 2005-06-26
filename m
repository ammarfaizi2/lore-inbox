Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVFZJ0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVFZJ0N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 05:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVFZJ0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 05:26:13 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:14564 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261218AbVFZJ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 05:26:11 -0400
Date: Sun, 26 Jun 2005 11:26:04 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Darryl L. Miles" <darryl@netbauds.net>, linux-kernel@vger.kernel.org,
       Christian Trefzer <ctrefzer@web.de>,
       Martin Wilck <martin.wilck@fujitsu-siemens.com>
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
Message-ID: <20050626092604.GA26658@ojjektum.uhulinux.hu>
References: <42BDFEC2.3030004@netbauds.net> <20050625234611.118b391d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050625234611.118b391d.akpm@osdl.org>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 11:46:11PM -0700, Andrew Morton wrote:
> I'd like to know what changed in the kernel to make nash's behaviour
> change.  Martin, did you work that out?

See http://lkml.org/lkml/2005/1/17/132


-- 
pozsy
