Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVF2AIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVF2AIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVF2AIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:08:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35282 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261365AbVF2AG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:06:26 -0400
Date: Tue, 28 Jun 2005 17:07:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 12/16] IB uverbs: add mthca user PD support
Message-Id: <20050628170718.0b2a9cad.akpm@osdl.org>
In-Reply-To: <2005628163.px5sYyzsYWf21dJY@cisco.com>
References: <2005628163.gtJFW6uLUrGQteys@cisco.com>
	<2005628163.px5sYyzsYWf21dJY@cisco.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> Add support for userspace protection domains (PDs) to mthca.

What is a userspace protection domain?
