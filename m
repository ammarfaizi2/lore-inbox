Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWF3L6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWF3L6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWF3L6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:58:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60074 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751767AbWF3L6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:58:36 -0400
Subject: Re: 2.6.17-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <1151661242.11434.20.camel@laptopd505.fenrus.org>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	 <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com>
	 <20060629204330.GC13619@redhat.com> <20060629210950.GA300@elte.hu>
	 <20060629230517.GA18838@elte.hu>
	 <1151662073.31392.4.camel@localhost.localdomain>
	 <1151661242.11434.20.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 13:14:30 +0100
Message-Id: <1151669670.31392.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 11:54 +0200, ysgrifennodd Arjan van de Ven:
> another quick hack is to check for vesa lb... eg if pci is present, skip
> this thing entirely :)

Not really, many people made VLB/PCI combo boards.

Alan

