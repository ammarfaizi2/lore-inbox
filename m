Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbWFLXjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWFLXjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 19:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWFLXjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 19:39:55 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:57551 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932639AbWFLXjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 19:39:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 04/21] swap_prefetch: Convert nr_mapped to ZVC
Date: Tue, 13 Jun 2006 09:36:15 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com> <20060612211305.20862.34292.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211305.20862.34292.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130936.16632.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 07:13, Christoph Lameter wrote:
> swap_prefetch: nr_mapped conversion
>
> This is separate on request by Andrew.
>
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

Acked-by: Con Kolivas <kernel@kolivas.org>

-- 
-ck
