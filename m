Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262680AbTCJAPZ>; Sun, 9 Mar 2003 19:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262682AbTCJAPZ>; Sun, 9 Mar 2003 19:15:25 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:10899 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262680AbTCJAPY>; Sun, 9 Mar 2003 19:15:24 -0500
Date: Mon, 10 Mar 2003 01:25:53 +0100
From: Andi Kleen <ak@muc.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Work around console initialization ordering problem
Message-ID: <20030310002553.GA1845@averell>
References: <20030309163242.GA2335@averell> <20030309134506.5809262b.akpm@digeo.com> <20030309233447.GA1701@averell> <20030309235701.GA3854@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309235701.GA3854@win.tue.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 12:57:01AM +0100, Andries Brouwer wrote:
> But what about COMMAND_LINE_SIZE?

It's normally 2k. Is that likely to be reached?

-Andi
