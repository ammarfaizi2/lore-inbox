Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVIGWos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVIGWos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVIGWos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:44:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10435 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932187AbVIGWor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:44:47 -0400
Date: Wed, 7 Sep 2005 15:44:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][MM] cleanup rionet and use updated rio message
 interface
Message-Id: <20050907154444.4f38462d.akpm@osdl.org>
In-Reply-To: <20050907081751.C1925@cox.net>
References: <20050907081751.C1925@cox.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter <mporter@kernel.crashing.org> wrote:
>
> This is the rionet cleanup patch previously posted in reply to Jeff's
> concerns with this driver. It depends on the rapidio messaging interface
> updates patch. 

Thanks.  So are there any outstanding issues with the rapidio patches?
