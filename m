Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268079AbUHQDHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUHQDHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 23:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHQDHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 23:07:52 -0400
Received: from holomorphy.com ([207.189.100.168]:55211 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268079AbUHQDHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 23:07:51 -0400
Date: Mon, 16 Aug 2004 20:07:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040817030748.GH11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816143710.1cd0bd2c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 02:37:10PM -0700, Andrew Morton wrote:
> - This kernel probably still has the ia64 scheduler startup bug, although it
>   works For Me.

AIUI that was fixed by kill-clone-idletask-fix.patch


-- wli
