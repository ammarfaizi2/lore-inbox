Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTKZNHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTKZNHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:07:45 -0500
Received: from [81.3.42.14] ([81.3.42.14]:54443 "EHLO syntheticsw.com")
	by vger.kernel.org with ESMTP id S262094AbTKZNHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:07:42 -0500
Message-ID: <1154.217.1.100.75.1069852084.squirrel@www.syntheticsw.com>
Date: Wed, 26 Nov 2003 14:08:04 +0100 (CET)
Subject: Support for KT400 AGP x8 + ATI drivers
From: "Torsten Giebl" <wizard@synolution.com>
To: linux-kernel@vger.kernel.org
Reply-To: wizard@synolution.com
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

I am using a VIA Board with KT400 chipset, AGP x8 (v3)
and the commercial ATI drivers for my Radeon 9600.

The standard 2.4.22 Kernel had the problem that AGP v3 was
not supported and AGPGart was not able to detect the AGP mem size.

My question is now is there a patch for the latest stable kernel
or do i have to use the dev. kernel ?


THANKS.
