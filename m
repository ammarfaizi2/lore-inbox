Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265320AbTLSB3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 20:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265322AbTLSB3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 20:29:36 -0500
Received: from cs666870-201.austin.rr.com ([66.68.70.201]:46977 "EHLO
	mod.homelinux.org") by vger.kernel.org with ESMTP id S265320AbTLSB3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 20:29:35 -0500
From: Yun Zhou <sraphim@mofd.net>
To: linux-kernel@vger.kernel.org
Subject: HD access sluggish in 2.6.0
Date: Thu, 18 Dec 2003 19:57:05 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312181957.05917.sraphim@mofd.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a system with 1HD (DC WD600BB-00CAA1 60 GB) using kernel 2.6.0. 
Whenever the system uses the disk extensively (copying a file, untarring, 
etc.), it grinds to a near halt, with the CPU usage at about 100%, even for a 
simple copying operation.

This problem is not present when using 2.4.22, nor any of the 2.4 series 
kernels that I've tried. Does anyone know what is causing this?

Thanks in advance!
