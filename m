Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWA3MPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWA3MPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 07:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWA3MPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 07:15:17 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:45723 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932241AbWA3MPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 07:15:15 -0500
Date: Mon, 30 Jan 2006 10:15:09 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: Re: [PATCH 0/4] - pktgen: refinements and small fixes (V2).
Message-Id: <20060130101509.674bb081.lcapitulino@mandriva.com.br>
In-Reply-To: <17373.62964.203852.42375@robur.slu.se>
References: <20060129232342.1e481f9a@localhost>
	<17373.62964.203852.42375@robur.slu.se>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006 12:18:12 +0100
Robert Olsson <Robert.Olsson@data.slu.se> wrote:

| 
| Luiz Fernando Capitulino writes:
| 
|  > [PATCH 1/4]  pktgen: Lindent run.
|  > [PATCH 2/4]  pktgen: Ports thread list to Kernel list implementation.
|  > [PATCH 3/4]  pktgen: Fix kernel_thread() fail leak.
|  > [PATCH 4/4]  pktgen: Fix Initialization fail leak.
|  > 
|  >  The changes from V1 are:
|  > 
|  >  1. More fixes made by hand after Lindent run
|  >  2. Re-diffed agains't Dave's net-2.6.17 tree
| 
|  Should be fine I've used the previous version of the patches for a
|  couple of days now. Thanks.

 Ok Robert, I'll try to finish the interface list port this week.

| 
|  Signed-off-by: Robert Olsson <robert.olsson@its.uu.se>
| 
|  Cheers.	
| 					--ro

-- 
Luiz Fernando N. Capitulino
