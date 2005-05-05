Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVEEK7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVEEK7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 06:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVEEK7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 06:59:11 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:32714 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S262031AbVEEK7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 06:59:09 -0400
Message-Id: <1115290744.30022.233426961@webmail.messagingengine.com>
X-Sasl-Enc: nN+agx85TU1/us6tZT7F+nwv+u723r0+P+0ZFM/BbdEJ 1115290744
From: "Deepak" <deepakgaur@fastmail.fm>
To: linux-kernel@vger.kernel.org
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.5  (F2.73; T1.001; A1.64; B3.05; Q3.03)
Subject: Real Time Signals In Powerpc Linux
Date: Thu, 05 May 2005 19:59:04 +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am working on a linux (v 2.4.20) based powerpc(8260) board. During
development of an application program I planned to use real time
signals(SIGRTMIN to SIGRTMAX) for interprocess communication. On giving
the command 'kill -l' on the terminal window of ppc linux  it displayed
only 32 signals while giving the same command on an Intel based Linux PC
(same kernel version) showed all 64 signals. 

Anyone having idea whether these signals are present in powerpc Linux
kernal v 2.4.20 ?

Deepak Gaur
