Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVALJUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVALJUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 04:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVALJUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 04:20:41 -0500
Received: from postman2.arcor-online.net ([151.189.20.157]:207 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261304AbVALJUf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 04:20:35 -0500
Date: Wed, 12 Jan 2005 10:20:42 +0100
From: Tino Keitel <tino.keitel@gmx.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc1
Message-ID: <20050112092042.GA27528@dose.home.local>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> <41E4DEBB.90606@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E4DEBB.90606@ens-lyon.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 09:24:27 +0100, Brice Goglin wrote:

[...]

> Hi Linus,
> 
> setkeycodes does not work anymore on my Compaq Evo N600c running a Debian 
> testing.
> 
> puligny:~# setkeycodes e023 150 e01e 155 e01a 217 e01f 157
> KDSETKEYCODE: No such device
> failed to set scancode a3 to keycode 150

Did this work for you with 2.6.10? I currently use 2.6.9-mm1 and I get
the same error on Debian Sid.

Regards,
Tino
