Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVILTnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVILTnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVILTnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:43:31 -0400
Received: from silver.veritas.com ([143.127.12.111]:20611 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932177AbVILTnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:43:31 -0400
Date: Mon, 12 Sep 2005 20:43:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Tainted lsmod output
In-Reply-To: <Pine.LNX.4.50.0509121129470.30198-100000@shark.he.net>
Message-ID: <Pine.LNX.4.61.0509122039350.5019@goblin.wat.veritas.com>
References: <4325C713.6060908@latinsourcetech.com>
 <Pine.LNX.4.50.0509121129470.30198-100000@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Sep 2005 19:43:30.0618 (UTC) FILETIME=[40AF69A0:01C5B7D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2005, Randy.Dunlap wrote:
> 
>  *  'P' - Proprietary module has been loaded.
>  *  'F' - Module has been forcibly loaded.
>  *  'S' - SMP with CPUs not designed for SMP.
>  *  'R' - User forced a module unload.
>  *  'M' - Machine had a machine check experience.
>  *  'B' - System has hit bad_page.

The one that puzzles me greatly isn't listed there: 'G'

Hugh
