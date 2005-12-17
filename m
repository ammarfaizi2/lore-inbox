Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVLQUBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVLQUBw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVLQUBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:01:52 -0500
Received: from waste.org ([64.81.244.121]:35533 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932581AbVLQUBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:01:51 -0500
Date: Sat, 17 Dec 2005 11:54:48 -0800
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: remove CONFIG_UID16
Message-ID: <20051217195447.GG8637@waste.org>
References: <20051217044410.GO23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217044410.GO23349@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 05:44:10AM +0100, Adrian Bunk wrote:
> It seems noone noticed that CONFIG_UID16 was accidentially always 
> disabled in the latest -mm kernels.

Hmm, did I break it?

-- 
Mathematics is the supreme nostalgia of our time.
