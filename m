Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265458AbTFZIPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 04:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265459AbTFZIPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 04:15:49 -0400
Received: from pop.gmx.net ([213.165.64.20]:56710 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265458AbTFZIPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 04:15:49 -0400
Message-Id: <5.2.0.9.2.20030626103217.02002168@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 26 Jun 2003 10:34:14 +0200
To: "Shawn Starr" <spstarr@sh0n.net>
From: Mike Galbraith <efault@gmx.de>
Subject: RE: Speeding up Linux kernel compiles using -pipe?
Cc: "'Anton Blanchard'" <anton@samba.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <000001c33b7e$7b3959a0$030aa8c0@panic>
References: <20030625052940.GA18786@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:01 PM 6/25/2003 -0400, Shawn Starr wrote:
>Nevermind, We are using pipe, I just didn't see due to the new Makefile
>output (V=1) shows me we are using pipe, at least for ia32.

Unless something has changed recently, -pipe is actually a slowdown.

         -Mike 

