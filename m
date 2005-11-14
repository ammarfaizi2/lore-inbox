Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVKNVLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVKNVLT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVKNVLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:11:19 -0500
Received: from gold.veritas.com ([143.127.12.110]:31506 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932107AbVKNVLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:11:18 -0500
Date: Mon, 14 Nov 2005 15:58:50 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <20051114145252.GT20871@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0511141556480.4428@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511101251060.7127@goblin.wat.veritas.com>
 <20051114145252.GT20871@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Nov 2005 21:11:17.0961 (UTC) FILETIME=[F44A6B90:01C5E95F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2005, Michael S. Tsirkin wrote:
> 
> Okay, here's an updated version.

Looked good to me, but as usual Gleb noticed what I missed.  And you
should be working against 2.6.15-rc1 or 2.6.15-rc1-git, not 2.6.14.

Hugh
