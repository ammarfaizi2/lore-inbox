Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVATTHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVATTHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVATTEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:04:09 -0500
Received: from holomorphy.com ([66.93.40.71]:25033 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261777AbVATTCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:02:32 -0500
Date: Thu, 20 Jan 2005 10:59:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] unexport profile_pc
Message-ID: <20050120185917.GM8896@holomorphy.com>
References: <20050120182019.GJ3174@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120182019.GJ3174@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 07:20:19PM +0100, Adrian Bunk wrote:
> I haven't found any modular usage of profile_pc in the kernel.
> Is the patch below correct?
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

In theory, /proc/ can be modular. In practice...


-- wli
