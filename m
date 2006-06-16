Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWFPTTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWFPTTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWFPTTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:19:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:20613 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750896AbWFPTTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:19:50 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] Use zoned VM Counters for NUMA statistics V2
Date: Fri, 16 Jun 2006 21:19:41 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0606161118210.15940@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606161118210.15940@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606162119.41293.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> so that it fits again into one cacheline on 32 bit NUMA
> with a 64 byte cacheline. 

I don't think such a beast exists so far. So from that
angle it doesn't help.

-Andi
