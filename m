Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVASOzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVASOzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVASOzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:55:15 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:4286 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261737AbVASOzJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:55:09 -0500
In-Reply-To: <1106146083.26551.526.camel@hades.cambridge.redhat.com>
References: <1106146083.26551.526.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <115DD72E-6A2A-11D9-AC28-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Paul Mackerras" <paulus@samba.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Jon Masters" <jonathan@jonmasters.org>, "Olaf Hering" <olh@suse.de>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "linuxppc-dev list" <linuxppc-dev@ozlabs.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] raid6: altivec support
Date: Wed, 19 Jan 2005 08:54:49 -0600
To: "David Woodhouse" <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 19, 2005, at 8:48 AM, David Woodhouse wrote:

> On Wed, 2005-01-19 at 08:45 -0600, Kumar Gala wrote:
>  > We did talk about looking at using some work Ben did in ppc64 with 
> OF
> > in ppc32.  John Masters was looking into this, but I havent heard 
> much
>  > from him on it lately.
>  >
> > The firmware interface on the ppc32 embedded side is some what broken
> > in my mind.
>
> The binary structure which changes every few weeks and which is shared
>  between the bootloader and the kernel? Yeah, "somewhat broken" is one
> way of putting it :)
>
> The ARM kernel does it a lot better with tag,value pairs.

The funny thing is that one of the variants on ppc32 supports tag, 
value pairs

- kumar
