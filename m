Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbTGCS6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 14:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbTGCS6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 14:58:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16777 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265239AbTGCS6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 14:58:17 -0400
Date: Thu, 3 Jul 2003 12:06:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: wli@holomorphy.com, mbligh@aracnet.com, mel@csn.ul.ie, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: What to expect with the 2.6 VM
Message-Id: <20030703120658.4fb1e407.akpm@osdl.org>
In-Reply-To: <20030703113144.GY23578@dualathlon.random>
References: <20030702171159.GG23578@dualathlon.random>
	<461030000.1057165809@flay>
	<20030702174700.GJ23578@dualathlon.random>
	<20030702214032.GH20413@holomorphy.com>
	<20030702220246.GS23578@dualathlon.random>
	<20030702221551.GH26348@holomorphy.com>
	<20030702222641.GU23578@dualathlon.random>
	<20030702231122.GI26348@holomorphy.com>
	<20030702233014.GW23578@dualathlon.random>
	<20030702235540.GK26348@holomorphy.com>
	<20030703113144.GY23578@dualathlon.random>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Yet another issue is that mlock at max locks in half of the physical
> ram,

I deleted that bit.
