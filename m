Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTFPPsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 11:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbTFPPsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 11:48:42 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:38311 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S264025AbTFPPsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 11:48:40 -0400
Date: Mon, 16 Jun 2003 17:02:32 +0100
From: Ian Molton <spyro@f2s.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FRAMEBUFFER policy
Message-Id: <20030616170232.5214424c.spyro@f2s.com>
In-Reply-To: <Pine.GSO.4.21.0306161411410.15789-100000@vervain.sonytel.be>
References: <20030616020012.3f2d27dd.spyro@f2s.com>
	<Pine.GSO.4.21.0306161411410.15789-100000@vervain.sonytel.be>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003 14:12:45 +0200 (MEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> 
> If you pass a mode that cannot be handled, the driver must try to
> round up some values to make it work. If that's not possible, an error
> is returned.

Great, thanks.

-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.
