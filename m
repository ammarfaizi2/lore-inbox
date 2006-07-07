Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWGGPnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWGGPnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWGGPnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:43:32 -0400
Received: from main.gmane.org ([80.91.229.2]:52200 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751199AbWGGPnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:43:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Steve Fox <drfickle@us.ibm.com>
Subject: Re: Linux v2.6.18-rc1
Date: Fri, 07 Jul 2006 10:41:35 -0500
Organization: IBM
Message-ID: <pan.2006.07.07.15.41.35.528827@us.ibm.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 24-159-197-73.dhcp.roch.mn.charter.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Cc: linuxppc-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've got a ppc64 machine that won't boot with this due to an IDE error.

[snip]
Freeing unused kernel memory: 256k freed
 running (1:2) /init autobench_args: ABAT:1152213829

creating device nodes .hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt

-- 

Steve Fox
IBM Linux Technology Center


