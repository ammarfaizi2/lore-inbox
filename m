Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVHDNnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVHDNnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVHDNnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:43:11 -0400
Received: from [85.8.12.41] ([85.8.12.41]:27019 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262531AbVHDNnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:43:06 -0400
Message-ID: <42F21B49.2070308@drzeus.cx>
Date: Thu, 04 Aug 2005 15:42:33 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-0.1.fc5 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jgarzik@pobox.com
CC: "John W. Linville" <linville@tuxdriver.com>,
       LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] 8139cp - redetect link after suspend
References: <42C8653D.9040103@drzeus.cx> <20050705145945.GA21933@tuxdriver.com>
In-Reply-To: <20050705145945.GA21933@tuxdriver.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:

>On Mon, Jul 04, 2005 at 12:22:53AM +0200, Pierre Ossman wrote:
>  
>
>>After suspend the driver needs to retest link status in case the cable
>>has been inserted or removed during the suspend.
>>
>>Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
>>    
>>
>
>Please copy netdev@vger.kernel.org for network driver patches.
>
>Other than that, the patch looks acceptable to me, fwiw...
>  
>

Has anyone had else had the time to review this? Jeff especially.

Rgds
Pierre

