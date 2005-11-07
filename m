Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVKGO0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVKGO0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVKGO0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:26:36 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:55303 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964827AbVKGO0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:26:35 -0500
Date: Mon, 7 Nov 2005 09:25:20 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Yan Zheng <yanzheng@21cn.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Stevens <dlstevens@us.ibm.com>
Subject: Re: [PATCH][MCAST]Clear MAF_GSQUERY flag when process MLDv1 general query messages.
Message-ID: <20051107142517.GA13797@tuxdriver.com>
Mail-Followup-To: Yan Zheng <yanzheng@21cn.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Stevens <dlstevens@us.ibm.com>
References: <436F610E.8010400@21cn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436F610E.8010400@21cn.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 10:13:34PM +0800, Yan Zheng wrote:

> MAF_GSQUERY flag may cause problem when MLDv1 compatibility mode expires.  

Could you be more specific about what problem it will cause?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
