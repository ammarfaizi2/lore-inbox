Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUC3Ckx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 21:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUC3Ckx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 21:40:53 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:49792 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261787AbUC3Ckw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 21:40:52 -0500
Date: Mon, 29 Mar 2004 21:35:18 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Lucas de Souza Santos <lucasdss@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Isa/i2c [bug report]
Message-ID: <20040329213518.GB3237@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Lucas de Souza Santos <lucasdss@yahoo.com.br>,
	linux-kernel@vger.kernel.org
References: <406796DD.6000800@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406796DD.6000800@yahoo.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 12:24:13AM -0300, Lucas de Souza Santos wrote:
> Hi,
>
> i'm running 2.6.5-rc2-bk7 and i'm having some problems with sensors and
>   my sound blaster ISA-awe 64. With 2.6.4 everything is working, but in
> 2.6.5.rc2-bk7 my isa cards (sb-awe64 and sym53c416) are in conflict and
> sensors of my motherboard stop to work.
>
> I have to disable my sym53c416 (isa-scsi card) for my sound work, but
> with 2.6.4 its work fine together.
>

Could I see more information regarding the ISA conflict?  Perhaps a dmesg,
/proc/interrupts, etc.

Thanks,
Adam
