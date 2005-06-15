Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVFOHEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFOHEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 03:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFOHEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 03:04:53 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:50840 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261266AbVFOHEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 03:04:39 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Pavel Machek <pavel@ucw.cz>,
       Jurriaan <thunder7@xs4all.nl>
Subject: Re: [Linux-fbdev-devel] Re: new framebuffer fonts + updated 12x22 font available
Date: Wed, 15 Jun 2005 15:03:34 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, adaplas@pol.net, benh@kernel.crashing.org,
       linux-fbdev-devel@lists.sourceforge.net
References: <20050610132331.GA8643@middle.of.nowhere> <20050613195953.GA467@openzaurus.ucw.cz>
In-Reply-To: <20050613195953.GA467@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506151503.40348.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 03:59, Pavel Machek wrote:
> Hi!
>
> > I've spent my offline-vacation on improving the fonts for use with the
> > framebuffer.
> >
> > I've added all the characters marked 'FIXME' in the sun12x22 font and
> > created a 10x18 font (based on the sun12x22 font) and a 7x14 font (based
> > on the vga8x16 font).
>
> Great! Is there any chance for bigger than 12x22 fonts? With some hi-res
> panels in notebooks, even 12x22 looks pretty small...
> 				Pavel

You can try these (from Jani Jaakkola)

http://www.cs.helsinki.fi/u/jjaakkol/psf/bitstream_vera_sans_mono_roman.16x30.psf
http://www.cs.helsinki.fi/u/jjaakkol/psf/bitstream_vera_sans_mono_roman.17x32.psf

Tony


