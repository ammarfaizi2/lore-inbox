Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312421AbSCUSMD>; Thu, 21 Mar 2002 13:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSCUSLy>; Thu, 21 Mar 2002 13:11:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34828 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312421AbSCUSLn>; Thu, 21 Mar 2002 13:11:43 -0500
Subject: Re: [PATCH][CFT] CD-MRW (Mt Rainier) support
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Thu, 21 Mar 2002 18:27:28 +0000 (GMT)
Cc: axboe@suse.de (Jens Axboe), linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20020321175944.GC3201@matchmail.com> from "Mike Fedyk" at Mar 21, 2002 09:59:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o7Hc-0005vH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Mar 21, 2002 at 02:12:01PM +0100, Jens Axboe wrote:
> > # ./mtr -d /dev/hdc -f full
> 
> You may need to rename this biary since I think some other tools use this
> name also...

Yes - mtr is a graphical/text mode trace route/ping/etc tool
