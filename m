Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTHZV2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 17:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTHZV2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 17:28:21 -0400
Received: from hockin.org ([66.35.79.110]:9739 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262770AbTHZV2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 17:28:20 -0400
Date: Tue, 26 Aug 2003 14:11:34 -0700
From: Tim Hockin <thockin@hockin.org>
To: Ro0tSiEgE LKML <lkml@ro0tsiege.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Missing natsemi PCI ID
Message-ID: <20030826141134.A27085@hockin.org>
References: <000501c36c10$c292c120$0500000a@bp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000501c36c10$c292c120$0500000a@bp>; from lkml@ro0tsiege.org on Tue, Aug 26, 2003 at 03:29:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 03:29:33PM -0500, Ro0tSiEgE LKML wrote:
> The computer is an HP Pavilion ze4145 notebook. Most of the devices do not
> have corresponding PCI ID's in the kernel, but I am only worried about the
> NIC right now.

What's wrong with the NIC?

> 00:12.0 Ethernet controller: National Semiconductor Corporation DP83815

if you load the natsemi driver, what do you get?

-- 
Notice that as computers are becoming easier and easier to use,
suddenly there's a big market for "Dummies" books.  Cause and effect,
or merely an ironic juxtaposition of unrelated facts?

