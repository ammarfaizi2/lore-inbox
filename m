Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbSKUPfy>; Thu, 21 Nov 2002 10:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSKUPfy>; Thu, 21 Nov 2002 10:35:54 -0500
Received: from [155.223.251.1] ([155.223.251.1]:56723 "HELO gatekeeper")
	by vger.kernel.org with SMTP id <S266761AbSKUPfx>;
	Thu, 21 Nov 2002 10:35:53 -0500
From: "Halil Demirezen" <nitrium@bilmuh.ege.edu.tr>
To: linux-kernel@vger.kernel.org
Subject: so slow
Date: Thu, 21 Nov 2002 17:58:55 +0800
Message-Id: <20021121175855.M58597@bilmuh.ege.edu.tr>
X-Mailer: Open WebMail 1.64 20020415
X-OriginatingIP: 155.223.26.109 (nitrium)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tail -f /var/log/kern.log


Nov 20 08:02:29 xxx kernel: sending pkt_too_big to self
Nov 20 08:04:05 xxx kernel: sending pkt_too_big to self
Nov 20 08:05:58 xxx kernel: sending pkt_too_big to self

according to you, does this situation make the system slow down to a
reasonanle status?



-hd
