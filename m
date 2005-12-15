Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVLOObX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVLOObX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVLOObX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:31:23 -0500
Received: from kanga.kvack.org ([66.96.29.28]:39839 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750704AbVLOObW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:31:22 -0500
Date: Thu, 15 Dec 2005 09:28:01 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Yasunori Goto <y-goto@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, tony.luck@intel.com
Subject: Re: 2.6.15-rc5-mm2 can't boot on ia64 due to changing on_each_cpu().
Message-ID: <20051215142801.GA2444@kvack.org>
References: <20051215103344.241C.Y-GOTO@jp.fujitsu.com> <20051214185658.7a60aa07.akpm@osdl.org> <20051215030040.GA28660@kvack.org> <43A0FE0D.6030100@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A0FE0D.6030100@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 02:24:29PM +0900, Kenji Kaneshige wrote:
> How about this?

Excellent!  Thanks Kenji.  Tony, are you okay with this patch going in?

		-ben
