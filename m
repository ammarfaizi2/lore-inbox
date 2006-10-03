Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbWJCTNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbWJCTNL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbWJCTNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:13:11 -0400
Received: from 200-42-47-10.static.prima.net.ar ([200.42.47.10]:35857 "EHLO
	mail.shellcode.com.ar") by vger.kernel.org with ESMTP
	id S1030482AbWJCTNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:13:09 -0400
Subject: =?ISO-8859-1?Q?Registration=A0Weakness=A0?=
	=?ISO-8859-1?Q?in=A0Linux=A0Kernel's=A0Bin?= =?ISO-8859-1?Q?ary=A0formats?=
From: SHELLCODE Security Research <GoodFellas@shellcode.com.ar>
Reply-To: goodfellas@shellcode.com.ar
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Oct 2006 19:13:05 +0000
Message-Id: <1159902785.2855.34.camel@goku.staff.locallan>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
To: undisclosed-recipients:;
X-AV-Checked: AV using SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
The present document aims to demonstrate a design weakness found in the
handling of simply 
linked   lists   used   to   register   binary   formats   handled   by
Linux   kernel,   and   affects   all   the   kernel families
(2.0/2.2/2.4/2.6), allowing the insertion of infection modules in
kernel­ space that can be used by malicious users to create infection
tools, for example rootkits.

POC, details and proposed solution at:
English version: http://www.shellcode.com.ar/docz/binfmt-en.pdf
Spanish version: http://www.shellcode.com.ar/docz/binfmt-es.pdf

regards,
--
SHELLCODE Security Research TEAM
GoodFellas@shellcode.com.ar
http://www.shellcode.com.ar


