Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWJMMna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWJMMna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 08:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbWJMMna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 08:43:30 -0400
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:19416 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751624AbWJMMna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 08:43:30 -0400
Message-ID: <452F89F1.3060708@grupopie.com>
Date: Fri, 13 Oct 2006 13:43:29 +0100
From: Paulo Marques <pmarques@grupopie.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>
In-Reply-To: <20061013023218.31362830.maxextreme@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda Sandonis wrote:
> Andrew, here it is the complete patch again as you requested.
> 
> Paulo, I got the algorithm much faster, thanks you very much.
> (<2% CPU at 20 Hz on P4 3Ghz :).
> ---
> miguelojeda-2.6.19-rc1-add-LCD-support.patch
> 
> Adds support for auxiliary displays, the ks0108 LCD controller,
> the cfag12864b LCD and adds a framebuffer device: cfag12864bfb.
> [...]
> Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>

Acked-by: Paulo Marques <pmarques@grupopie.com>

-- 
Paulo Marques - www.grupopie.com
