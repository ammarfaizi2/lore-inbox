Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264527AbUESUNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUESUNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 16:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264529AbUESUNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 16:13:23 -0400
Received: from vogsphere.datenknoten.de ([212.12.48.49]:10635 "EHLO
	vogsphere.datenknoten.de") by vger.kernel.org with ESMTP
	id S264527AbUESUM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 16:12:57 -0400
Subject: Re: Strange DMA-errors... (was: ...and system hang with Promise
	20268)
From: Sebastian <sebastian@expires0604.datenknoten.de>
To: samg@seven4sky.com
Cc: "Mario 'BitKoenig' Holbe" <mario.holbe@rz.tu-ilmenau.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1648.128.150.143.219.1084992082.squirrel@webmail.seven4sky.com>
References: <1078602426.16591.8.camel@vega> <c2dsha$psd$1@sea.gmane.org>
	 <1084987258.4662.4.camel@coruscant.datenknoten.de>
	 <20040519172845.GA26122@darkside.22.kls.lan>
	 <1084990345.4371.5.camel@coruscant.datenknoten.de>
	 <1648.128.150.143.219.1084992082.squirrel@webmail.seven4sky.com>
Content-Type: text/plain
Message-Id: <1084997577.7392.5.camel@coruscant.datenknoten.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 May 2004 22:12:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Am Mi, den 19.05.2004 schrieb Sam Gill um 20:41:
> Have you tried changing the dma settings
> 
> turn off dma

yes, it probably will help as DMA is currently on, however, that is not
an option as I need acceptable hard drive performance. As I said, the
system worked nicely until that kernel update. If no hardware failure is
causing this, it must be a change in the kernel. I will replace the hard
disk and see if the problem disappears.

Sebastian

