Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263661AbUECMd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUECMd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbUECMd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:33:29 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:45440 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263661AbUECMd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:33:28 -0400
Date: Mon, 3 May 2004 22:33:22 +1000
To: linux-kernel@vger.kernel.org
Cc: bluefoxicy@linux.net
Subject: Re Huge pages
Message-ID: <20040503123322.GQ16626@chubb.wattle.id.au>
References: <20040503082600.3490.54918.Mailman@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503082600.3490.54918.Mailman@lists.us.dell.com>
User-Agent: Mutt/1.3.27i
From: Lucy Chubb <lucy@chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 03:26:00AM -0500, linux-kernel-digest-request@lists.us.dell.com wrote:

> Can anyone at least enlighten me as to if huge pages must be
> 4KiB page or 4MiB page aligned?

That would depend on the architecture but I would expect 4MB alignment
to required normally.

LucyC
