Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUHVNCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUHVNCu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 09:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUHVNCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 09:02:50 -0400
Received: from holomorphy.com ([207.189.100.168]:19588 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266837AbUHVNCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 09:02:49 -0400
Date: Sun, 22 Aug 2004 06:02:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040822130247.GD1510@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <20040821173759.GA3045@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821173759.GA3045@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 10:37:59AM -0700, William Lee Irwin III wrote:
> Oopsed almost instantly after I logged in as root on the one box I
> can't do console logging on and can't afford downtime on. =(

It's the known alignment-related non-pfifo qdisc bug. No cause for concern.


-- wli
