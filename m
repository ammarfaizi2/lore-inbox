Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTDDMDq (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 07:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263690AbTDDMDp (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 07:03:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23176
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263687AbTDDMDi (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 07:03:38 -0500
Subject: Re: [PATCH] interlaced packed pixels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0304041310440.1720-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0304041310440.1720-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049454984.2138.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Apr 2003 12:16:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-04 at 12:17, Geert Uytterhoeven wrote:
> 	Hi,
> 
> I'd like to introduce a new frame buffer type to accommodate packed pixel frame
> buffers that store the even and odd fields separately. This is typically used
> in graphics hardware for TV output (e.g. set-top boxes).

While we are at it can we also get an FB_TYPE_MJPEG ?

