Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265573AbUATQZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 11:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUATQZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 11:25:47 -0500
Received: from relaycz.systinet.com ([62.168.12.68]:19138 "HELO
	relaycz.systinet.com") by vger.kernel.org with SMTP id S265573AbUATQZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 11:25:46 -0500
Subject: Re: DMA timeout error and then kernel halted
From: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <400C1D16.5010008@domdv.de>
References: <1074533362.7913.14.camel@narsil>  <400C1D16.5010008@domdv.de>
Content-Type: text/plain
Message-Id: <1074615933.1188.1.camel@narsil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 17:25:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-19 at 19:08, Andreas Steinmetz wrote:
> I do have similar problems with a HPT302 and WD2500JB disks on a Tyan 
> S2885 (Dual Opteron 246). What does help me is to disable the IO-APICs 
> at boot time using "noapic".
> 
> Thus I don't believe this to be a disk/mobo problem but probably a 
> driver problem.

Thanks, I'll try it. What will I loose not using IO-APIC?

Jan "Pogo" Mynarik

-- 
Jan Mynarik <mynarikj@phoenix.inf.upol.cz>

