Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbUKRJSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbUKRJSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 04:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUKRJSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 04:18:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:42936 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262691AbUKRJSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 04:18:15 -0500
Date: Thu, 18 Nov 2004 01:17:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: haveblue@us.ibm.com, Ian.Pratt@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value
Message-Id: <20041118011753.23a88b45.akpm@osdl.org>
In-Reply-To: <E1CUhlm-0003Ro-00@mta1.cl.cam.ac.uk>
References: <1100741201.12373.276.camel@localhost>
	<E1CUhlm-0003Ro-00@mta1.cl.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser <Keir.Fraser@cl.cam.ac.uk> wrote:
>
> PG_foreign

Is Xen using PG_arch_1?  If not, it can be used for this.
