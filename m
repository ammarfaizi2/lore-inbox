Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319336AbSIGHXo>; Sat, 7 Sep 2002 03:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319447AbSIGHXo>; Sat, 7 Sep 2002 03:23:44 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:49426 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S319336AbSIGHXo>;
	Sat, 7 Sep 2002 03:23:44 -0400
Date: Sat, 7 Sep 2002 09:39:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adam Johnson <adamj@valley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: kernel 2.5.33 won't compile
Message-ID: <20020907093956.A1826@mars.ravnborg.org>
Mail-Followup-To: Adam Johnson <adamj@valley.net>,
	linux-kernel@vger.kernel.org
References: <3D7926C0.7010906@valley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D7926C0.7010906@valley.net>; from adamj@valley.net on Fri, Sep 06, 2002 at 06:05:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 06:05:52PM -0400, Adam Johnson wrote:
>     I get this error message when I try to compile 2.5.33:
> drivers/built-in.o(.data+0x2d8d4): undefined reference to `local symbols 
> in discarded section .text.exit'

Try seaching ihttp://marc.theaimsgroup.com
Hint: binutils compatibility problem, time to upgrade.

	Sam
