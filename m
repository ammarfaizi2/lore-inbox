Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTIBD3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 23:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTIBD3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 23:29:38 -0400
Received: from main.gmane.org ([80.91.224.249]:18636 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263426AbTIBD3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 23:29:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: laptopkernel: dead?
Date: Mon, 01 Sep 2003 22:29:33 -0500
Message-ID: <bj12qt$70m$1@sea.gmane.org>
References: <200309011423.15797.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:

> Hello,
> 
> Just a quick question: is the laptopkernel kernelpatch dead? Last update
> was for 2.4.21-rc8 ...
> 
> Jan

well, the ACPI changes (the main thing it contained, though not the only
thing) were merged into mainline, so I suspect that's why the branch
fizzled .

