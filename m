Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWADRTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWADRTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWADRTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:19:08 -0500
Received: from 5301d.unt0.torres.l21.ma.zugschlus.de ([217.151.83.1]:10686
	"EHLO torres.zugschlus.de") by vger.kernel.org with ESMTP
	id S964812AbWADRTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:19:06 -0500
Date: Wed, 4 Jan 2006 18:19:05 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
Message-ID: <20060104171905.GM8079@torres.l21.ma.zugschlus.de>
References: <200601041710.37648.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601041710.37648.nick@linicks.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 05:10:37PM +0000, Nick Warne wrote:
> A stupid question - buggered if I can find a kernel patch from 2.6.14.5 to 
> 2.6.15?

You can try backing out the 2.6.14 -> 2.6.14.5 patch to generate a
"pristine" 2.6.14 to which you can apply 2.6.14 -> 2.6.15.

This mess is one reason while I usually keep old kernel tarballs
around for a while.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
