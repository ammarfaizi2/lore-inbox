Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUJTO4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUJTO4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267528AbUJTO4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:56:05 -0400
Received: from colin2.muc.de ([193.149.48.15]:49938 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261474AbUJTOzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:55:33 -0400
Date: 20 Oct 2004 16:55:32 +0200
Date: Wed, 20 Oct 2004 16:55:32 +0200
From: Andi Kleen <ak@muc.de>
To: Espen Fjellv?r Olsen <espenfjo@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 amd64 Computer crashes on "Freeing unused kernel memory: 200k"
Message-ID: <20041020145532.GA9689@muc.de>
References: <2QMVB-2nB-13@gated-at.bofh.it> <m3wtxn67h2.fsf@averell.firstfloor.org> <7aaed09104101908174a9e430a@mail.gmail.com> <7aaed09104101914093ff72736@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aaed09104101914093ff72736@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:09:10PM +0200, Espen Fjellv?r Olsen wrote:
> I'm sending my dmesg and lspci output, and my .config files.

Does it work with "noapic" or "nolapic" or "acpi=off" or 
"noapic acpi_irq_balance" ? 

-Andi
