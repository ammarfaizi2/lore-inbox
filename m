Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbREXOgH>; Thu, 24 May 2001 10:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbREXOf5>; Thu, 24 May 2001 10:35:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30483 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262045AbREXOfl>; Thu, 24 May 2001 10:35:41 -0400
Subject: Re: Transmeta Crusoe support?
To: jeffchua@silk.corp.fedex.com (Jeff Chua)
Date: Thu, 24 May 2001 15:33:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel), jchua@fedex.com (Jeff Chua)
In-Reply-To: <Pine.LNX.4.33.0105241809180.1129-100000@boston.corp.fedex.com> from "Jeff Chua" at May 24, 2001 06:25:26 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152wAq-00053X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Question is whether I need to recompile everything (kernel and binaries)
> on my current 586 platform in order to move to Crusoe?

No. Crusoe should work out of the box in that sense. Its actually however
not brilliantly documented for things like longrun mode where folks have
actually been poking around the acpi data in order to find out how the thing
works... thats the ironic part 8)

> 

