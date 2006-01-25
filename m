Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWAYNxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWAYNxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 08:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWAYNxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 08:53:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64921 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751166AbWAYNxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 08:53:22 -0500
Date: Wed, 25 Jan 2006 14:52:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Add support for soft scrollback
In-Reply-To: <43D492C4.3000801@gmail.com>
Message-ID: <Pine.LNX.4.61.0601251451310.26305@yvahk01.tjqt.qr>
References: <43D492C4.3000801@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This patch adds this feature.  The feature and the size of the buffer
>are made as a kernel config option.  Besides consuming kernel memory,
>this feature will slow down the console by approximately 20%.

Slower? Then I would rather prefer compact oopses.



Jan Engelhardt
-- 
