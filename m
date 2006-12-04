Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936792AbWLDUSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936792AbWLDUSh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937365AbWLDUSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:18:37 -0500
Received: from [81.2.110.250] ([81.2.110.250]:40621 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-??-OK-FAIL) by vger.kernel.org with ESMTP
	id S936792AbWLDUSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:18:36 -0500
Date: Mon, 4 Dec 2006 20:16:01 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [PATCH] make sata_promise PATA ports work
Message-ID: <20061204201601.06933372@localhost.localdomain>
In-Reply-To: <20061204194737.GA24311@codepoet.org>
References: <20061204194737.GA24311@codepoet.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 12:47:37 -0700
Erik Andersen <andersen@codepoet.org> wrote:

> This patch vs 2.6.19, based on the not-actually-working-for-me
> code lurking in libata-dev.git#promise-sata-pata, makes the PATA
> ports on my promise sata card actually work.  Since the plan as

Nice, this is pretty much what is needed to polish up the other split
PATA/SATA cases.

