Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281289AbRKPKtU>; Fri, 16 Nov 2001 05:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281294AbRKPKtK>; Fri, 16 Nov 2001 05:49:10 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:22277 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281292AbRKPKtE>; Fri, 16 Nov 2001 05:49:04 -0500
Date: Fri, 16 Nov 2001 11:49:02 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: infinite loop in 3c509 driver IRQ loop?
Message-ID: <20011116114902.K5520@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I caught a complaint by Linux 2.2.19 which has a 3C509B that it ran into
an infinite loop in its IRQ handler. Driver bug?

Thanks in advance,

-- 
Matthias Andree
