Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbSL3WF0>; Mon, 30 Dec 2002 17:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSL3WF0>; Mon, 30 Dec 2002 17:05:26 -0500
Received: from holomorphy.com ([66.224.33.161]:47081 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265857AbSL3WFZ>;
	Mon, 30 Dec 2002 17:05:25 -0500
Date: Mon, 30 Dec 2002 14:12:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] fix o(1) handling of threads
Message-ID: <20021230221224.GP29422@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
References: <200212301645.50278.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212301645.50278.tomlins@cam.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 04:45:50PM -0500, Ed Tomlinson wrote:
> The o(1) scheduler is an interesting beast.  It handles most workloads

O(1) is very, very different from o(1). Don't skip that shift key!

Also see:

	http://mathworld.wolfram.com/AsymptoticNotation.html


Bill
