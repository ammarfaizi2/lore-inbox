Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262034AbTCHOmT>; Sat, 8 Mar 2003 09:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262037AbTCHOmT>; Sat, 8 Mar 2003 09:42:19 -0500
Received: from [195.208.223.247] ([195.208.223.247]:1152 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262034AbTCHOmS>; Sat, 8 Mar 2003 09:42:18 -0500
Date: Sat, 8 Mar 2003 17:53:01 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Christian <evilninja@gmx.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_ALPHA_SRM not compiling on 2.5
Message-ID: <20030308175301.A736@localhost.park.msu.ru>
References: <3E6538EF.3060602@gmx.net> <20030305005309.GM27794@lug-owl.de> <3E692DEB.2030207@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E692DEB.2030207@gmx.net>; from evilninja@gmx.net on Sat, Mar 08, 2003 at 12:40:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 12:40:27AM +0100, Christian wrote:
> Linux version 2.5.63 #7 Wed Mar 05 [...]
> 
> halt code = 7
> machine check while inPAL mode
> PC = 14a0c
> >>>

This has been fixed in 2.5.64.

Ivan.
