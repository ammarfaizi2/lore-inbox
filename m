Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUANLwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 06:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUANLwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 06:52:21 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:51342 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261152AbUANLwU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 06:52:20 -0500
Message-ID: <004201c3da94$e4b29670$0e25fe0a@southpark.ae.poznan.pl>
From: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
To: "Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <31058754212B50469824909BE90A4CFB402EEC@ILEX2.IL.NDS.COM>
Subject: Re: kernel 2.6
Date: Wed, 14 Jan 2004 12:52:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> modprobe: QM_MODULS : function not  implemented
> 
> can you help?
sure. You need module-init-tools
please read the modules section and known gotchas at:
http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt

Regards,
Maciej

