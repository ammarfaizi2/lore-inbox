Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVCQV5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVCQV5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVCQV5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:57:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:54936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261229AbVCQVyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:54:17 -0500
Date: Thu, 17 Mar 2005 13:54:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Abhinkar, Sameer" <sameer.abhinkar@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KGDB question
Message-Id: <20050317135417.6cee8336.akpm@osdl.org>
In-Reply-To: <D30E01168D637641AA9D3667F3BB741603F9125F@orsmsx403.amr.corp.intel.com>
References: <D30E01168D637641AA9D3667F3BB741603F9125F@orsmsx403.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Abhinkar, Sameer" <sameer.abhinkar@intel.com> wrote:
>
> Are there any patches or hooks
> available to enable KGDB for linux-2.6.11.2? 

kgdb patches are maintained in -mm kernels.

Patches are in 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/broken-out/*kgdb*

And the patch application order is described in

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/patch-series
