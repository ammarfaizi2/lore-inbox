Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755881AbWKQUyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbWKQUyI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755879AbWKQUyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:54:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46273 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753168AbWKQUyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:54:05 -0500
Date: Fri, 17 Nov 2006 12:51:59 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Divy Le Ray <divy@chelsio.com>" <divy@chelsio.com>
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/10] cxgb3 - offload capabilities
Message-ID: <20061117125159.530b46c7@freekitty>
In-Reply-To: <20061117202539.25951.95325.stgit@colfax2.asicdesigners.com>
References: <20061117202539.25951.95325.stgit@colfax2.asicdesigners.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 12:25:39 -0800
"Divy Le Ray <divy@chelsio.com>" <divy@chelsio.com> wrote:

> From: Divy Le Ray <divy@chelsio.com>
> 
> This patch implements the offload capabilities of the
> Chelsio network adapter's driver.

Could you implement these as sysfs attributes on the device instead of
through /proc?
