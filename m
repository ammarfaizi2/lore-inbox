Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWC0WAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWC0WAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWC0WAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:00:01 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:49675 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751487AbWC0V76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:59:58 -0500
Date: Mon, 27 Mar 2006 16:56:30 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [2.6 patch] PCMCIA_SPECTRUM must select FW_LOADER
Message-ID: <20060327215626.GO14403@tuxdriver.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <44241FF9.9070904@ums.usu.ru> <20060324165619.GG22727@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324165619.GG22727@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 05:56:19PM +0100, Adrian Bunk wrote:

> PCMCIA_SPECTRUM must select FW_LOADER.
> 
> Reported by "Alexander E. Patrakov" <patrakov@ums.usu.ru>.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Merged to the 'upstream' branch of wireless-2.6.

Thanks!

John
-- 
John W. Linville
linville@tuxdriver.com
