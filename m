Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267544AbUG3ADI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267544AbUG3ADI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267541AbUG3ABr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:01:47 -0400
Received: from [66.35.79.110] ([66.35.79.110]:46542 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261682AbUG3AAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 20:00:03 -0400
Date: Thu, 29 Jul 2004 16:59:50 -0700
From: Tim Hockin <thockin@hockin.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org
Subject: Re: How to increase max number of groups per uid ?
Message-ID: <20040729235950.GA8987@hockin.org>
References: <20040729193106.43d4c515.skraw@ithnet.com> <20040729163407.02bb2dd6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729163407.02bb2dd6.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 04:34:07PM -0700, Andrew Morton wrote:
> 2.6 kernels support up to 65536 groups per user.

And it's trivial to increase beyond that, if you *really* need.
