Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132516AbRD2GUf>; Sun, 29 Apr 2001 02:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132691AbRD2GU0>; Sun, 29 Apr 2001 02:20:26 -0400
Received: from mail.gator.com ([63.197.87.182]:19217 "EHLO mail.gator.com")
	by vger.kernel.org with ESMTP id <S132516AbRD2GUW>;
	Sun, 29 Apr 2001 02:20:22 -0400
From: "George Bonser" <george@gator.com>
To: <linux-kernel@vger.kernel.org>
Subject: Subjective 2.4.4 performance report
Date: Sat, 28 Apr 2001 23:22:38 -0700
Message-ID: <CHEKKPICCNOGICGMDODJEEDNCOAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will know better when the load ramps up next week but 2.4.4 (with Al
Viro's prune_icache() patch) just seems to "feel" better than the previous
2.4 kernels did. This is a UP Pentium-III with 256MB RAM used as a web
server with about 100 connections open as I write this and serving about 50
requests/sec.

Note this machine does not run X or have any users logged in, it is just a
plain old web server (Debian Woody and Apache).

Now that I have said this it will likely turn into a smoking heap of
silicon.

