Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbUCOOie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 09:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUCOOh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 09:37:28 -0500
Received: from mailhub.ariel.cs.yorku.ca ([130.63.92.20]:12514 "EHLO
	green.cs.yorku.ca") by vger.kernel.org with ESMTP id S262587AbUCOOgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 09:36:55 -0500
Date: Mon, 15 Mar 2004 09:36:54 -0500 (EST)
From: Andrew Hogue <hogue@cs.yorku.ca>
To: linux-kernel@vger.kernel.org
Subject: SATA on 2.4.x
Message-ID: <Pine.LNX.4.58.0403150934590.21510@wormwood.cs.yorku.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using a via8237 southbridge with sata support.  I know that there is
support for this in 2.6.x but I cannot use 2.6.x due to some
incompatibility with my hardware.

Is there a patch to allow the via 8237 sata controller to work for kernel
2.4.x ?

Thanks,

-- Andrew

