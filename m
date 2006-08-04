Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161283AbWHDQXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161283AbWHDQXg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161284AbWHDQXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:23:36 -0400
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:53714 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1161283AbWHDQXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:23:36 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.3
Subject: Re: Problem: irq 217: nobody cared + backtrace
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <9a8748490608040736n5c9ea078x79f4ce56b613703a@mail.gmail.com>
References: <9a8748490608030717x1db108f1m2cc616459bb776db@mail.gmail.com>
	 <Pine.LNX.4.44L0.0608031158560.7384-100000@iolanthe.rowland.org>
	 <9a8748490608040736n5c9ea078x79f4ce56b613703a@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 17:23:29 +0100
Message-Id: <1154708610.6075.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 16:36 +0200, Jesper Juhl wrote:
> >
> > Has this happened more than once?
> 
> Seems to happen consistently after ~100000 interrupts. 

yap , I remember this same number when I cat  /proc/interrupts

