Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWJLSiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWJLSiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWJLSiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:38:15 -0400
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:2525 "EHLO
	aa014msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750956AbWJLSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:38:10 -0400
Date: Thu, 12 Oct 2006 20:38:12 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: KDE confuses 2.6.19-rc1+ AKA "cdrom: This disc doesn't have any
  tracks I recognize!"
Message-ID: <20061012203812.1d2cc027@localhost>
In-Reply-To: <20061012181950.GO6515@kernel.dk>
References: <20061012162727.207b730c@localhost>
	<20061012181950.GO6515@kernel.dk>
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 20:19:50 +0200
Jens Axboe <jens.axboe@oracle.com> wrote:

> > The kernel stays "confused" even if I close KDE...
> > 
> > I'm using KDE 3.5.4.
> 
> Try current -git, it should be fixed now.

Yes, it works  :)

-- 
	Paolo Ornati
	Linux 2.6.19-rc1-g9eb20074 on x86_64
