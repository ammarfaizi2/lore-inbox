Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264498AbUDZMNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUDZMNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbUDZMNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:13:11 -0400
Received: from reverendtimms.isu.mmu.ac.uk ([149.170.192.65]:28859 "EHLO
	reverendtimms.isu.mmu.ac.uk") by vger.kernel.org with ESMTP
	id S264498AbUDZMNI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:13:08 -0400
From: David Johnson <dj@david-web.co.uk>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: Re: 8139too not working in 2.6
Date: Mon, 26 Apr 2004 13:13:37 +0100
User-Agent: KMail/1.6
References: <opr62ahdvlpsnffn@mail.mcaserta.com> <200404261405.20078.koke_lkml@amedias.org>
In-Reply-To: <200404261405.20078.koke_lkml@amedias.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200404261313.37870.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 Apr 2004 13:05, Jorge Bernal (Koke) wrote:
>
> I have tried with 2.6.5 and now with 2.6.6-rc2-mm1 and works perfectly.
> This message is going through that card ;)

Do you mean that both 2.6.5 and 2.6.6-rc2-mm1 worked or that only 
2.6.6-rc2-mm1 worked and 2.6.5 didn't?

>
> Mine is:
> 00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>

I should have said what my card is shouldn't I...

>From dmesg:
eth0: RealTek RTL8139 at 0xe0914000, 00:90:f5:25:91:22, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'

>From lspci:
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)


-- 
David Johnson
http://www.david-web.co.uk/
