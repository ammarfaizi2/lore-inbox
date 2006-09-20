Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751720AbWITQLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWITQLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbWITQLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:11:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58831 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751718AbWITQLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:11:17 -0400
Date: Wed, 20 Sep 2006 09:11:08 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] Remove ZONE_DMA remains from avr32
In-Reply-To: <20060920145952.2ea78f17@cad-250-152.norway.atmel.com>
Message-ID: <Pine.LNX.4.64.0609200910420.30529@schroedinger.engr.sgi.com>
References: <20060920145952.2ea78f17@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Haavard Skinnemoen wrote:

> Put all available lowmem in ZONE_NORMAL now that ZONE_DMA can be
> disabled (which is the right thing to do on AVR32.)
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

Acked-by: Christoph Lameter <clameter@sgi.com>
