Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRB0ORg>; Tue, 27 Feb 2001 09:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129435AbRB0ORZ>; Tue, 27 Feb 2001 09:17:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11022 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129413AbRB0ORK>; Tue, 27 Feb 2001 09:17:10 -0500
Subject: Re: Unexpected IRQ trap at vector 20
To: dennis.noordsij@wiral.com (Dennis Noordsij)
Date: Tue, 27 Feb 2001 14:19:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01022716105200.01136@dennis> from "Dennis Noordsij" at Feb 27, 2001 04:10:52 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Xkyr-0003Vg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> etc, plugging in the power (while the system was running on battery - this 
> causes the CPU to step up to 700MHz from 550MHz) causes the system to freeze 
> in every way (including SysRq), while continuously spitting out "Unexpected 
> IRQ trap at vector 20" on the serial console. 

Thats the laptop firmware or the speedstep support logic. There isnt anything
we can do until Intel give us docs on speedstep

Alan

