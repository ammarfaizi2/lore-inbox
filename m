Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWJXPdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWJXPdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWJXPdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:33:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5844 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030204AbWJXPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:33:24 -0400
Date: Tue, 24 Oct 2006 08:32:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] optional ZONE_DMA for s390
In-Reply-To: <20061024123106.GA7118@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.64.0610240832110.3577@schroedinger.engr.sgi.com>
References: <20061024123106.GA7118@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006, Heiko Carstens wrote:

> For non-64BIT systems all memory is DMA capable.

Acked-by: Christoph Lameter <clameter@sgi.com>

