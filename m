Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbWFLXln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWFLXln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 19:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbWFLXln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 19:41:43 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:46552 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932644AbWFLXlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 19:41:42 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 17/21] swap_prefetch: Conversion of nr_writeback to ZVC
Date: Tue, 13 Jun 2006 09:38:23 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com> <20060612211412.20862.5280.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211412.20862.5280.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130938.24227.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 07:14, Christoph Lameter wrote:
> Subject: swap_prefetch: conversion of nr_writeback to per zone counter
> From: Christoph Lameter <clameter@sgi.com>
>
> Conversion of nr_writeback to per zone counter
>
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
Acked-by: Con Kolivas <kernel@kolivas.org>

-- 
-ck
