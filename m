Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbUKJUf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUKJUf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUKJUfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:35:25 -0500
Received: from ozlabs.org ([203.10.76.45]:62090 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262122AbUKJUbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:31:49 -0500
Date: Thu, 11 Nov 2004 07:30:58 +1100
From: Anton Blanchard <anton@samba.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Bump MAX_HWIFS in IDE code
Message-ID: <20041110203058.GA1922@krispykreme.ozlabs.ibm.com>
References: <20041109203028.GA26806@krispykreme.ozlabs.ibm.com> <20041109125507.4bc49b3c.akpm@osdl.org> <20041109211201.GA8998@taniwha.stupidest.org> <1100038365.3946.236.camel@gaston> <58cb370e04111010055ed26378@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e04111010055ed26378@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anton, IDE driver is limited to 10 major numbers anyway
> so please just use 10 for now...

Thanks Bart, will do.

Anton
