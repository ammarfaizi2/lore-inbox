Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbTBAO7O>; Sat, 1 Feb 2003 09:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTBAO7O>; Sat, 1 Feb 2003 09:59:14 -0500
Received: from mailg.telia.com ([194.22.194.26]:60098 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S264857AbTBAO7O>;
	Sat, 1 Feb 2003 09:59:14 -0500
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Message-ID: <004701c2ca03$cb467460$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linux-kernel@vger.kernel.org>
Subject: NETIF_F_SG question
Date: Sat, 1 Feb 2003 16:08:36 +0100
Organization: Lumentis AB
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am thinking of implementing harware scatter/gatter support( NETIF_F_SG) in my 
ethernet driver. The network device cannot do HW checksuming.

Will the IP stack make use of the SG support and will there be any significant performance
improvement?

 Jocke  
