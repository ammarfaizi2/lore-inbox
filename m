Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265518AbTLHRqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbTLHRqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:46:05 -0500
Received: from intra.cyclades.com ([64.186.161.6]:21377 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265518AbTLHRqD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:46:03 -0500
Date: Mon, 8 Dec 2003 15:34:58 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Power-Netz (Schwarz)" <schwarz@power-netz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HyperThreading with 2.4.23 and Dual Intel Xenon
In-Reply-To: <OBECJKACIGIAEGMGGKMPKECDFEAA.schwarz@power-netz.de>
Message-ID: <Pine.LNX.4.44.0312081534500.1289-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, Power-Netz (Schwarz) wrote:

> 
> Hi ,
> 
> we compiled 2.4.23 for 2 cpus but we don't get Hyperthreading working.
> with 2.4.20 and the machine, it work without probs.
> 
> Any ideas? 

Change CONFIG_NR_CPUS to 8. 

