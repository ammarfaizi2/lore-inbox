Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWCLRlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWCLRlV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWCLRlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:41:21 -0500
Received: from smtp12.wanadoo.fr ([193.252.22.20]:39350 "EHLO
	smtp12.wanadoo.fr") by vger.kernel.org with ESMTP id S1751371AbWCLRlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:41:20 -0500
X-ME-UUID: 20060312174117285.45C681C00096@mwinf1208.wanadoo.fr
Message-ID: <44145D3C.1000307@free.fr>
Date: Sun, 12 Mar 2006 18:41:16 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: eric.valette@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Probable circular dependencies : make bzlilo rebuild nearly everything
 after make bzImage
References: <44144C7C.8030704@free.fr>
In-Reply-To: <44144C7C.8030704@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette wrote:
> Started around 2.6.15.3 and is still there in 2.6.16-rc6

Just seen a post from Petr Vandrovec complaining about make 3.81rc1 that 
I also use (debian unstable) => probably same bug. Will try patch and 
report.

-- eric

