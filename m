Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263444AbSIPXOY>; Mon, 16 Sep 2002 19:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263446AbSIPXOY>; Mon, 16 Sep 2002 19:14:24 -0400
Received: from web13207.mail.yahoo.com ([216.136.174.192]:10830 "HELO
	web13207.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263444AbSIPXOV>; Mon, 16 Sep 2002 19:14:21 -0400
Message-ID: <20020916231919.32664.qmail@web13207.mail.yahoo.com>
Date: Mon, 16 Sep 2002 16:19:19 -0700 (PDT)
From: Srinivas Chavva <chavvasrini@yahoo.com>
Subject: Re: Configuring kernel
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020916231344.A1328@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am extremely sorry I made a typing error. When I
executed the command make xconfig I got the following
output
rm -f include/asm
(cd include; ln -sf asm -i386 asm)
make -C scripts kconfig.tk
make: *** scripts: No such file or directory. Stop.
make: *** [xconfig] Error 2

Please help me to fix the error.
Thanking You.
Regards,
Srinivas Chavva

--- Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sun, Sep 15, 2002 at 03:34:08PM -0700, Srinivas
> Chavva wrote:
> > When I tried to execute the command "make xconfig"
> I
> > got the following output
> > 
> > rm -f include/asm
> > (cd include; ln -sf asm -i386 asm)
> > make -C scripts knconfig.tk
> There is no file named "knconfig.tk" - check your
> top-level Makefile.
> The correct name is "kconfig.tk".
> 
> 	Sam


__________________________________________________
Do you Yahoo!?
Yahoo! News - Today's headlines
http://news.yahoo.com
