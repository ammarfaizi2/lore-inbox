Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132737AbREBLXF>; Wed, 2 May 2001 07:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbREBLW4>; Wed, 2 May 2001 07:22:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17423 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132737AbREBLWi>; Wed, 2 May 2001 07:22:38 -0400
Subject: Re: PROBLEM: (follow-up) 2.4.4, ac1,ac2,ac3 - panics on ICMPv6 packets
To: cliff@oisec.net (Cliff Albert)
Date: Wed, 2 May 2001 12:26:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010502083928.A30793@oisec.net> from "Cliff Albert" at May 02, 2001 08:39:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uum6-0003Qn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  2.4.4, ac1, ac2 AND now ac3 will panic on receiving ICMPv6 packets (like traceroute6 and ping6)
>  See my earlier messages for panic info.

Does building without netfilter support help ?
