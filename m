Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268183AbUHTPpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268183AbUHTPpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268224AbUHTPpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:45:44 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:34244 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268183AbUHTPow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:44:52 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8.1-mm3
Date: Fri, 20 Aug 2004 11:44:49 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org>
In-Reply-To: <20040820031919.413d0a95.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201144.49522.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 6:19 am, Andrew Morton wrote:
> - This is (very) lightly tested.  Mainly a resync with various parties.

Woo-hoo!  This boots *without changes* on a 512p Altix!  Now to re-run the 
profiles and try wli's new per-cpu profiling buffers.

Jesse
