Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273349AbRJKHCz>; Thu, 11 Oct 2001 03:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273358AbRJKHCp>; Thu, 11 Oct 2001 03:02:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59664 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273349AbRJKHC0>; Thu, 11 Oct 2001 03:02:26 -0400
Subject: Re: -ac10,-ac11 no boot on SMP PentiumII box
To: cshihpin@dso.org.sg (Richard Chan)
Date: Thu, 11 Oct 2001 08:08:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011011110327.B25934@cshihpin.dso.org.sg> from "Richard Chan" at Oct 11, 2001 11:03:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rZx5-0002H4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Normally I would expect "Calibrating delay loop..." but no go.
> 
> Last -ac kernel tried was 2.4.9-ac10 with success.
> 2.4.10 stock also works.
> 
> Has anything affected the CPU startup code?

Not that I am aware of. There are some locking changes in specific cases
but I tested that still booted on my dual PPro

Alan
