Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266278AbRGBAAi>; Sun, 1 Jul 2001 20:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266279AbRGBAA2>; Sun, 1 Jul 2001 20:00:28 -0400
Received: from imladris.infradead.org ([194.205.184.45]:19730 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S266278AbRGBAAO>;
	Sun, 1 Jul 2001 20:00:14 -0400
Date: Mon, 2 Jul 2001 01:00:04 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Re: gcc: internal compiler error: program cc1 got fatal signal
 11]
In-Reply-To: <9hobhc$7p3$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107020058270.18977-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi HPA.

 >> Some time ago I installed Linux (Redhat 6.0) on my pc (Cx486 8M
 >> RAM) and gcc had a lot of signal 11 (a couple every hour) I was
 >> upgrading the kernel every time there was a new kernel and from
 >> 2.2.12(or 14) no more signal 11 (very rare) Is this still a
 >> hardware problem ? Was a bug in kernel ?

 >> I think the last answer is more obvious.(or the gcc had a bug
 >> and the kernel -- a workaround).

 > Most likely is that your *hardware* had a bug and the new kernel
 > a workaround (this is quite common), but without more detail it
 > is very hard to know.

Wasn't 2.2.12 the kernel that included the `lock halt` bug patch?

Best wishes from Riley.

