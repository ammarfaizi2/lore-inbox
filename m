Return-Path: <linux-kernel-owner+w=401wt.eu-S1751029AbXACSNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbXACSNs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 13:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbXACSNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 13:13:48 -0500
Received: from nevyn.them.org ([66.93.172.17]:55887 "EHLO nevyn.them.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbXACSNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 13:13:47 -0500
Date: Wed, 3 Jan 2007 13:13:40 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Contents of core dumps
Message-ID: <20070103181340.GA19332@nevyn.them.org>
Mail-Followup-To: David Miller <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20060406.153518.60508780.davem@davemloft.net> <20060406.221807.114721185.davem@davemloft.net> <20070103020228.GA28762@nevyn.them.org> <20070102.205721.98552646.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102.205721.98552646.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 08:57:21PM -0800, David Miller wrote:
> So I'd say we should just put this change in, as-is.  It fixes bugs,
> and in all the time that has passed since my initial posting there
> has not been any serious dissent.

Fine with me.  In that case, I will wait until the kernel is fixed,
verify it, and then probably adjust the GDB test to pass on either
patched or unpatched kernels.

-- 
Daniel Jacobowitz
CodeSourcery
