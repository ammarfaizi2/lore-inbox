Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263034AbSIPVIs>; Mon, 16 Sep 2002 17:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbSIPVIs>; Mon, 16 Sep 2002 17:08:48 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:9746 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263034AbSIPVIr>;
	Mon, 16 Sep 2002 17:08:47 -0400
Date: Mon, 16 Sep 2002 23:13:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Srinivas Chavva <chavvasrini@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Configuring kernel
Message-ID: <20020916231344.A1328@mars.ravnborg.org>
Mail-Followup-To: Srinivas Chavva <chavvasrini@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <3D83A943.3010200@davehollis.com> <20020915223408.51335.qmail@web13201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020915223408.51335.qmail@web13201.mail.yahoo.com>; from chavvasrini@yahoo.com on Sun, Sep 15, 2002 at 03:34:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 03:34:08PM -0700, Srinivas Chavva wrote:
> When I tried to execute the command "make xconfig" I
> got the following output
> 
> rm -f include/asm
> (cd include; ln -sf asm -i386 asm)
> make -C scripts knconfig.tk
There is no file named "knconfig.tk" - check your top-level Makefile.
The correct name is "kconfig.tk".

	Sam
