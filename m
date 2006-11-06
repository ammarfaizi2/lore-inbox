Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423726AbWKFKNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423726AbWKFKNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423723AbWKFKNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:13:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47786 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423726AbWKFKNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:13:06 -0500
Subject: Re: ZONE_NORMAL memory exhausted by 4000 TCP sockets
From: Arjan van de Ven <arjan@infradead.org>
To: Zhao Xiaoming <xiaoming.nj@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
References: <f55850a70611052207j384e1d3flaf40bb9dd74df7c5@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 06 Nov 2006 11:13:04 +0100
Message-Id: <1162807984.3160.188.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 14:07 +0800, Zhao Xiaoming wrote:
> Dears,
>     I'm running a linux box with kernel version 2.6.16. The hardware
> has 2 Woodcrest Xeon CPUs (2 cores each) and 4G RAM. The NIC cards is
> Intel 82571 on PCI-e bus.

are you using a 32 bit or a 64 bit OS?


