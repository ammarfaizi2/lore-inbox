Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTFTOa1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTFTOa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:30:27 -0400
Received: from imap.gmx.net ([213.165.64.20]:28069 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262324AbTFTOa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:30:26 -0400
Message-ID: <005601c3373a$88638440$0200a8c0@brainbug>
Reply-To: "Thomas Frase" <thomas.frase@ist-einmalig.de>
From: "Thomas Frase" <thomas.frase@herr-der-mails.de>
To: "Rus Foster" <rghf@fsck.me.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <004d01c33738$7031e440$0200a8c0@brainbug> <20030620153321.V31879@thor.65535.net>
Subject: Re: root shell exploit still working in kernel 2.4.21
Date: Fri, 20 Jun 2003 16:44:59 +0200
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

> Under 2.4.21 delete the binary, recompile it and see if it still
happens.
> The binary sets itself SUID IIRC
>
> Rgds
>
> Rus

that was it. sorry i didn't check that first.

