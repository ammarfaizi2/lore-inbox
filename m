Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVCOLFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVCOLFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 06:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVCOLFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 06:05:11 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64429
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261725AbVCOLFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 06:05:02 -0500
Subject: Re: RFC: CANbus subsytem for 2.6 kernel (char or netdev)
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4236B1D1.7030707@varma-el.com>
References: <4236B1D1.7030707@varma-el.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 12:04:59 +0100
Message-Id: <1110884699.5812.10.camel@atlas.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anyone could told me, why everyone, who wrote CANbus driver (peak, 
> kvaser etc) always use char dev, but not netdev for it? May be exist 
> some global pitfall, which I couldn't see, which prevent to use netdev?

Maybe you try out:
http://www.linutronix.de/data/linux-2.6.11-can.diff

Bene

