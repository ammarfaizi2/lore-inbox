Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132737AbRDDCkW>; Tue, 3 Apr 2001 22:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbRDDCkM>; Tue, 3 Apr 2001 22:40:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31499 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132737AbRDDCkC>; Tue, 3 Apr 2001 22:40:02 -0400
Subject: Re: 2.4.3 freeze under heavy writing + open rxvt
To: sim@netnation.com (Simon Kirby)
Date: Wed, 4 Apr 2001 03:41:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010403223222.A669@netnation.com> from "Simon Kirby" at Apr 03, 2001 10:32:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kdF2-00013Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Three times now I've had 2.4.3 freeze on my dual CPU box while doing a
> "dd if=/dev/zero of=/dev/hdc bs=1024k" (a drive to be RMA'd :)).  I got

Does it happen if you boot with < 900Mb of ram ?
