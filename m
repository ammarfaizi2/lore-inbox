Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVAOAJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVAOAJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVAOAJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:09:57 -0500
Received: from ns.suse.de ([195.135.220.2]:55009 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262021AbVAOAJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:09:56 -0500
Date: Sat, 15 Jan 2005 01:09:55 +0100
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [Patch] x86_64: use cpumask_t instead of unsigned long
Message-ID: <20050115000955.GA21578@wotan.suse.de>
References: <20050114133912.B13523@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114133912.B13523@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 01:39:13PM -0800, Siddha, Suresh B wrote:
> Another cpumask_t related fix. Please apply.

Thanks applied.
-Andi
