Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWAaQWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWAaQWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWAaQWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:22:53 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:53512 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751141AbWAaQWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:22:52 -0500
Date: Tue, 31 Jan 2006 11:19:27 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Gabriel C." <crazy@pimpmylinux.org>, linux-kernel@vger.kernel.org,
       da.crew@gmx.net, netdev@vger.kernel.org
Subject: Re: [2.6 patch] PCMCIA=m, HOSTAP_CS=y is not a legal configuration
Message-ID: <20060131161922.GQ5433@tuxdriver.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	"Gabriel C." <crazy@pimpmylinux.org>, linux-kernel@vger.kernel.org,
	da.crew@gmx.net, netdev@vger.kernel.org
References: <20060130133833.7b7a3f8e@zwerg> <20060130182317.GD3655@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130182317.GD3655@stusta.de>
User-Agent: Mutt/1.4.1i
X-Original-Status: RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 07:23:17PM +0100, Adrian Bunk wrote:

> CONFIG_PCMCIA=m, CONFIG_HOSTAP_CS=y doesn't compile.
> 
> Reported by "Gabriel C." <crazy@pimpmylinux.org>.

Applied to upstream-fixes branch of wireless-2.6.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
