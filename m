Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263144AbRFFNm3>; Wed, 6 Jun 2001 09:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263172AbRFFNmT>; Wed, 6 Jun 2001 09:42:19 -0400
Received: from imr2.ericy.com ([12.34.240.68]:7398 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id <S263144AbRFFNmG>;
	Wed, 6 Jun 2001 09:42:06 -0400
Message-ID: <32CD630F6CBED411AE180008C7894CBC05DC74B7@lmc37.lmc.ericsson.se>
From: "David Gordon (LMC)" <David.Gordon@ericsson.ca>
To: "'Arjan van de Ven'" <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: RE: kHTTPd hangs 2.4.5 boot when moduled
Date: Wed, 6 Jun 2001 09:41:46 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is very strange. Does your kernel do the same if you compile IPv6
> as module and khttpd off ?

No, the boot proceeds normally. I loaded ipv6 module manually after boot and
ipv6 worked locally also (ping6 ::1). I didn't test network ipv6 (my
personal computer is on an ipv4 network). Similarly, I was going to start
khttpd manually after boot wheb it hung.

David
