Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVADXmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVADXmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVADXlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:41:37 -0500
Received: from hera.cwi.nl ([192.16.191.8]:52893 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262120AbVADXi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:38:57 -0500
Date: Wed, 5 Jan 2005 00:38:41 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nikita Danilov <nikita@clusterfs.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] mm: overcommit updates
Message-ID: <20050104233841.GC10119@apps.cwi.nl>
References: <200501040611.j046BHoq005158@hera.kernel.org> <m14qhxmkw4.fsf@clusterfs.com> <1104857514.17176.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104857514.17176.33.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 10:03:56PM +0000, Alan Cox wrote:

> Looks like a broken merge to me. When the 3% trick was proposed I
> rewrote it as capabilities and submitted it to Linus, now it looks like
> some months later the original one has been regurgitated out of -mm

No. The two semi-identical fragments have independent origins.

Andries
