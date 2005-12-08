Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVLHOWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVLHOWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVLHOWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:22:32 -0500
Received: from iona.labri.fr ([147.210.8.143]:2515 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932148AbVLHOWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:22:32 -0500
Message-ID: <43984154.5050502@labri.fr>
Date: Thu, 08 Dec 2005 15:21:08 +0100
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to enable/disable security features on mmap() ?
References: <43983EBE.2080604@labri.fr> <1134051272.2867.63.camel@laptopd505.fenrus.org>
In-Reply-To: <1134051272.2867.63.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Arjan van de Ven wrote:
> 
> realistically the first one is easy if your hw supports the NX bit
> (x86/x86-64). Some of the other randomisations are present in the 2.6.x
> kernels.
> 
> Or run a kernel from Fedora Core, or a kernel with the PaX patches to
> get all you're asking for.

In fact, I'm more asking about how to turn it off. These features are
already included in the Linux kernel (2.6.14.x at least) but I didn't
find any CONFIG_XXX variables to configure these features.

(Well, I'm not sure about the NX bit support)

Regards
-- 
Emmanuel Fleury

The inside of my head was exploding with fireworks.
Fortunately, my last thought turned out the lights when it left.
  -- Calvin & Hobbes (Bill Waterson)
