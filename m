Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWHQLGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWHQLGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWHQLGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:06:13 -0400
Received: from ns2.hostinglmi.net ([213.194.149.12]:43984 "EHLO
	ns2.hostinglmi.net") by vger.kernel.org with ESMTP id S964803AbWHQLGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:06:11 -0400
Date: Thu, 17 Aug 2006 13:09:34 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: romieu@fr.zoreil.com, penberg@cs.Helsinki.FI, akpm@osdl.org,
       dvrabel@cantab.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 2/7] ip1000: remove some default phy params
Message-ID: <20060817110934.GA5504@fargo>
Mail-Followup-To: Jesse Huang <jesse@icplus.com.tw>, romieu@fr.zoreil.com,
	penberg@cs.Helsinki.FI, akpm@osdl.org, dvrabel@cantab.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1155843809.5006.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1155843809.5006.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns2.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pleyades.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

On Aug 17 at 03:43:29, Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> remove some default phy params
> 
> Change Logs:
>     remove some default phy params

First, thanks for finalling commiting this driver ;).

But please resend the patches with "Signed-off-by:"
line. I'm not much of a git hacker, but i think you
can use 'git-applymbox' to put a signedoff line in your
mbox-formatted patches.

regards,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
