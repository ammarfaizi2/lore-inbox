Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbVKIV3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbVKIV3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbVKIV3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:29:08 -0500
Received: from kanga.kvack.org ([66.96.29.28]:20142 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751444AbVKIV3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:29:07 -0500
Date: Wed, 9 Nov 2005 16:26:52 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] aio: remove kioctx from mm_struct
Message-ID: <20051109212652.GK14452@kvack.org>
References: <20051109211758.25027.78199.sendpatchset@volauvent.pdx.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109211758.25027.78199.sendpatchset@volauvent.pdx.zabbo.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 01:15:06PM -0800, Zach Brown wrote:
> 
> aio: remove kioctx from mm_struct

ACK.
