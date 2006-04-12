Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWDLQ7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWDLQ7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 12:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWDLQ7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 12:59:55 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:23827 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932216AbWDLQ7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 12:59:54 -0400
Date: Wed, 12 Apr 2006 18:59:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/POC] multiple CONFIG y/m/n
Message-ID: <20060412165929.GA20573@mars.ravnborg.org>
References: <20060406224134.0430e827.rdunlap@xenotime.net> <87odzdh1fp.fsf@duaron.myhome.or.jp> <20060409220426.8027953a.rdunlap@xenotime.net> <Pine.LNX.4.64.0604121253540.32445@scrub.home> <20060412091751.feba2dd4.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060412091751.feba2dd4.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMO the main points/questions are:
> 
> - where to document the command-line options and environment variables
>   (including the recent KCONFIG_CONFIG):  in a usage() function or in
>   Documentation/kbuild/usage.txt file?

The latter...
make help was the other alternative and it is too big already.

For kbuild I also need to add some stuff.

	Sam
