Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVLQUjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVLQUjz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLQUjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:39:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60641 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964945AbVLQUjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:39:20 -0500
Date: Sat, 17 Dec 2005 12:38:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 08/13]  [RFC] ipath core last bit
Message-Id: <20051217123856.d16529a5.akpm@osdl.org>
In-Reply-To: <200512161548.y9KRuNtfMzpZjwni@cisco.com>
References: <200512161548.3fqe3fMerrheBMdX@cisco.com>
	<200512161548.y9KRuNtfMzpZjwni@cisco.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> +EXPORT_SYMBOL(ipath_kset_linkstate);
> +EXPORT_SYMBOL(ipath_kset_mtu);
> +EXPORT_SYMBOL(ipath_layer_close);
> +EXPORT_SYMBOL(ipath_layer_get_bcast);
> +EXPORT_SYMBOL(ipath_layer_get_cr_errpkey);
> +EXPORT_SYMBOL(ipath_layer_get_deviceid);
> +EXPORT_SYMBOL(ipath_layer_get_flags);
> +EXPORT_SYMBOL(ipath_layer_get_guid);
> +EXPORT_SYMBOL(ipath_layer_get_ibmtu);
> etc

EXPORT_SMBOL_GPL?
