Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271712AbTG2Psm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271811AbTG2Psm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:48:42 -0400
Received: from indianer.linux-kernel.at ([212.24.125.53]:2457 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S271712AbTG2Pse convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:48:34 -0400
Message-Id: <200307291546.h6TFkMBV005386@indianer.linux-kernel.at>
From: Oliver Pitzeier <oliver@linux-kernel.at>
To: WHarms@bfs.de, linux-kernel@vger.kernel.org
Subject: RE: alpha; gas & linux 2.6.0-test1
Date: Tue, 29 Jul 2003 17:47:49 +0200
Organization: Linux Kernel Austria
X-Mailer: Oracle Outlook Connector 3.4 40812
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner-Information: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i tried to compile linux 2.6.0 unfortunaly the
> GNU assembler version 2.11.90.0.8 (alpha-redhat-linux) using 
> BFD version 2.11.90.0.8 has a problem:
> 
[ ... ]
> 
> I solved that with an upgrade to
> GNU assembler version 2.13 (alphaev56-unknown-linux-gnu) 
> using BFD version 2.13
> 
> there is already a check for as < 2.7 perhaps checking for 
> <2.13 would be better :)

as 2.12 runs at my machine. You know, I don't have troubles...

Best regards,
 Oliver

