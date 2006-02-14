Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWBNDUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWBNDUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWBNDUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:20:17 -0500
Received: from mail.gmx.net ([213.165.64.21]:61322 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750941AbWBNDUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:20:16 -0500
X-Authenticated: #271361
Date: Tue, 14 Feb 2006 04:20:02 +0100
From: Edgar Toernig <froese@gmx.de>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       ryan@tau.solarneutrino.net
Subject: Re: Randomly byteswapped audio
Message-Id: <20060214042002.4b92034d.froese@gmx.de>
In-Reply-To: <20060213211912.GD16566@tau.solarneutrino.net>
References: <20060213211912.GD16566@tau.solarneutrino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter wrote:
>
> I have a machine with a USB audio device (a Turtle Beach Audio Advantage
> Micro), and sometimes when e.g. a song plays I get an earful of
> byteswapped sound.
>[...]
> # Linux kernel version: 2.6.15

Fixed in 2.6.15.2.

Ciao, ET.
