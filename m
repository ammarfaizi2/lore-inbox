Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVKKBDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVKKBDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 20:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVKKBDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 20:03:33 -0500
Received: from holomorphy.com ([66.93.40.71]:52919 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S932322AbVKKBDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 20:03:32 -0500
Date: Thu, 10 Nov 2005 16:51:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, Adam Litke <agl@us.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] dequeue a huge page near to this node
Message-ID: <20051111005137.GR29402@holomorphy.com>
References: <200511102334.jAANY1g21612@unix-os.sc.intel.com> <Pine.LNX.4.62.0511101643120.17138@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0511101643120.17138@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 04:44:40PM -0800, Christoph Lameter wrote:
> Well in that case, we may do even more:
> Make huge pages obey cpusets.
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

Simple enough.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
