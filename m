Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275250AbTHMPwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275254AbTHMPwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:52:44 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:44043 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S275250AbTHMPwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:52:43 -0400
From: Ian Hastie <lkml@ordinal.freeserve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Realtek network card
Date: Wed, 13 Aug 2003 16:52:40 +0100
User-Agent: KMail/1.5.3
References: <20030813133059.616f0faa.skraw@ithnet.com>
In-Reply-To: <20030813133059.616f0faa.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308131652.41798.lkml@ordinal.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 Aug 2003 12:30, Stephan von Krawczynski wrote:
> Hello all,
>
> does anybody know how to make the below work (neiter 2.2.25 nor 2.4.21 seem
> to recognise it):
>
> lspci --vv:
>
> 00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown
> device 8131 (rev 10) Subsystem: Realtek Semiconductor Co., Ltd.: Unknown
> device 8139

Do you know what make and model the card actually is?  I know it what it 
appears to be, but it'd be best to know for sure.

-- 
Ian.

