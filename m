Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbULIWEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbULIWEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 17:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbULIWEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 17:04:48 -0500
Received: from holomorphy.com ([207.189.100.168]:10122 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261639AbULIWDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 17:03:40 -0500
Date: Thu, 9 Dec 2004 14:03:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Imanpreet Singh Arora <imanpreet@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question from Russells Spinlocks
Message-ID: <20041209220331.GF2714@holomorphy.com>
References: <41B76B7E.9020706@gmail.com> <41B8C952.3050104@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B8C952.3050104@didntduck.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Imanpreet Singh Arora wrote:
[...]

On Thu, Dec 09, 2004 at 04:53:22PM -0500, Brian Gerst wrote:
> In 2.6, the 24-bit limit is no longer valid.  atomic_t variables are a 
> full 32 bits on all arches now.

31 bits? They're signed IIRC.


-- wli
