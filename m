Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbTIBJql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 05:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTIBJql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 05:46:41 -0400
Received: from mail.native-instruments.de ([217.9.41.138]:3261 "EHLO
	mail.native-instruments.de") by vger.kernel.org with ESMTP
	id S263616AbTIBJqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 05:46:40 -0400
Message-ID: <004f01c37137$1b3e17e0$9602010a@jingle>
From: "Florian Schirmer" <jolt@tuxbox.org>
To: "Petr Baudis" <pasky@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>
References: <qAB6.4cu.17@gated-at.bofh.it>
Subject: Re: VESA fb weirdness in 2.6.0-test4-mm4
Date: Tue, 2 Sep 2003 11:46:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>   I'm running my kernel with (relevant parameters):
> video=radeonfb:off video=vga16fb:off vga=0x318 video=vesa:ywrap,mtrr

Should be video=vesafb:ywrap,mtrr....

Bye,
   Florian
