Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274866AbTHKWSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274868AbTHKWSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:18:43 -0400
Received: from holomorphy.com ([66.224.33.161]:28075 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S274866AbTHKWSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:18:41 -0400
Date: Mon, 11 Aug 2003 15:19:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-ID: <20030811221949.GH32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030809203943.3b925a0e.akpm@osdl.org> <94490000.1060612530@[10.10.2.4]> <20030811180552.GG32488@holomorphy.com> <200308120755.54518.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308120755.54518.kernel@kolivas.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 04:05, William Lee Irwin III wrote:
>> Is this with or without the unit conversion fix for the load balancer?
>> It will be load balancing extra-aggressively without the fix.

On Tue, Aug 12, 2003 at 07:55:54AM +1000, Con Kolivas wrote:
> Yes, test3-mm1 includes load balancing fix you suggested in an akpm modified 
> form.

Scratch that theory; I guess we're waiting to find out what Letext is.


-- wli
