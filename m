Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTJNH2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 03:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTJNH2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 03:28:42 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:47633 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S262228AbTJNH2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 03:28:41 -0400
Date: Tue, 14 Oct 2003 09:28:37 +0200
From: David Jez <dave.jez@seznam.cz>
To: Jan Marek <linux@hazard.jcu.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Q: how to set dma for device on ide-scsi?
Message-ID: <20031014072837.GA57968@stud.fit.vutbr.cz>
References: <20031013075829.GA14464@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013075829.GA14464@hazard.jcu.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 09:58:29AM +0200, Jan Marek wrote:
> Hallo l-k,
  Hi Jan!

> I have one question: how I can set dma mode for CD recorder in the
> ide-scsi emulation mode?
> 
> Hdparm demand work with /dev/sr0 or /dev/sg0... :-(
  Sure, you can use hdparm before loading ide-scsi module. It means, you
must compile ide-scsi as module and use hdparm to IDE device.

> Sincerely
> Jan Marek
  Have a nice day

> -- 
> Ing. Jan Marek
> University of South Bohemia
> Academic Computer Centre
> Phone: +420-38-7772080
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
