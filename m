Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVE1Dx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVE1Dx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 23:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVE1Dx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 23:53:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:33250 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261877AbVE1Dx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 23:53:56 -0400
Message-ID: <4297EB4C.2040004@pobox.com>
Date: Fri, 27 May 2005 23:53:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/sx8.c: remove unused code
References: <20050502014655.GV3592@stusta.de>
In-Reply-To: <20050502014655.GV3592@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Is it planned to ever #define IF_64BIT_DMA_IS_POSSIBLE ?
> 
> If not, the patch below removes this currently completely unused code.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

That code is there to be used at a later time.

	Jeff



