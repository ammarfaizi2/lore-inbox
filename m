Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264988AbUELHEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264988AbUELHEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 03:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbUELHEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 03:04:43 -0400
Received: from mail.teamfab.it ([151.17.201.167]:39373 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id S264988AbUELHEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 03:04:38 -0400
Message-ID: <40A1CB8E.9050202@teamlinux.it>
Date: Wed, 12 May 2004 09:00:30 +0200
From: Gabriele Giorgetti <gabriele@teamlinux.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out with 2.6.6-rc3-bk8
References: <1083875341.4603.20.camel@localhost.localdomain>
In-Reply-To: <1083875341.4603.20.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Gill wrote:
> Hi.  I recently built 2.6.6-rc3-bk8.  The boot process stalls with 
> ide-cd: cmd 0x5a timed out
> hdc: lost interrupt.
> hdc: lost interrupt.
> hdc: lost interrupt.
> hdc: lost interrupt.
> ide-cd: cmd 0x3 timed out
> ...

Same thing here with a SiS 962/963 and Linux 2.6.6.
2.6.5 was working just fine.
Also the acpi=noirq workaround works for me as well.


IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]

SiS 962/963 MuTIOL IDE UDMA133 controller

