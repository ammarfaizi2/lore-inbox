Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSKRQtT>; Mon, 18 Nov 2002 11:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSKRQtT>; Mon, 18 Nov 2002 11:49:19 -0500
Received: from holomorphy.com ([66.224.33.161]:5856 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263228AbSKRQtQ>;
	Mon, 18 Nov 2002 11:49:16 -0500
Date: Mon, 18 Nov 2002 08:53:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, rml@tech9.net,
       riel@surriel.com, akpm@zip.com.au
Subject: Re: unusual scheduling performance
Message-ID: <20021118165316.GK23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, mingo@elte.hu, rml@tech9.net,
	riel@surriel.com, akpm@zip.com.au
References: <20021118081854.GJ23425@holomorphy.com> <705474709.1037608454@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <705474709.1037608454@[10.10.2.3]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 08:34:34AM -0800, Martin J. Bligh wrote:
> 1. make -j <what?>
> 2. profiles?
> 3. Can you try the latest set of NUMA sched patches posted by Eric Focht?

(1) make -j64 bzImage
(2) doesn't sound useful for load balancing
(3) sure


Bill
