Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbRGEQRX>; Thu, 5 Jul 2001 12:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265912AbRGEQRN>; Thu, 5 Jul 2001 12:17:13 -0400
Received: from 35.roland.net ([65.112.177.35]:28935 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S265911AbRGEQRF>;
	Thu, 5 Jul 2001 12:17:05 -0400
Message-ID: <004401c1056e$03f71370$bb1cfa18@JimWS>
From: "Jim Roland" <jroland@roland.net>
To: <linux-kernel@vger.kernel.org>
Subject: PPP/MPPE Problem
Date: Thu, 5 Jul 2001 11:17:41 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have successfully (finally) installed MPPE and PPP with PPP 2.40 and Linux
Kernel 2.4.2.  However, anytime I allow and use MPPE-40 packets will not
forward into a VPN.  If I comment it out and use MPPE-STATELESS or MPPE-128
it works fine.  As soon as MPPE-40 is uncommented, it fails to operate.

What can I do to fix this?


