Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUDEHUD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 03:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUDEHUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 03:20:03 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:9862 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S261753AbUDEHUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 03:20:01 -0400
Subject: Re: 2.6.5-mm1 [PATCH]
From: Ray Lee <ray-lk@madrabbit.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mpm@selenic.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040404235526.09ff3c39.akpm@osdl.org>
References: <1081147276.1374.13.camel@orca.madrabbit.org>
	 <20040404235526.09ff3c39.akpm@osdl.org>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1081149599.1374.15.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Apr 2004 00:19:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-04-04 at 23:55, Andrew Morton wrote:
> The advantage of the ifdeffy one is that if someone accesses i_dquot
> outside CONFIG_QUOTA, they get a compile failure rather than runtime inode
> corruption.

Ah, that's useful. Point taken.

