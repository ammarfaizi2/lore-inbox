Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVG2GBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVG2GBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 02:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVG2GBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 02:01:50 -0400
Received: from dvhart.com ([64.146.134.43]:16058 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262416AbVG2GBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 02:01:18 -0400
Date: Thu, 28 Jul 2005 23:01:23 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <159960000.1122616883@[10.10.2.4]>
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA-Q boxes are still crashing on boot with -mm BTW. Is the thing we 
identified earlier with the sched patches ...

http://test.kernel.org/9398/debug/console.log

Works with mainline still (including -rc4) ... hopefully those patches 
aren't on their way upstream anytime soon ;-)

M.

