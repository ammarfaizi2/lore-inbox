Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263360AbSJFIyh>; Sun, 6 Oct 2002 04:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263361AbSJFIyh>; Sun, 6 Oct 2002 04:54:37 -0400
Received: from nl-ams-slo-l4-02-pip-6.chellonetwork.com ([213.46.243.24]:65343
	"EHLO amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S263360AbSJFIyg>; Sun, 6 Oct 2002 04:54:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Tim Spriggs <tims@fugazi.engr.arizona.edu>, mec@shout.net
Subject: Re: make menuconfig problem
Date: Sun, 6 Oct 2002 11:00:07 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0210052202560.21630-100000@fugazi.engr.arizona.edu>
In-Reply-To: <Pine.GSO.4.44.0210052202560.21630-100000@fugazi.engr.arizona.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021006090008.UREV2173.amsfep13-int.chello.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Configure the kernel in X (make xconfig) or edit .config by hand. I've 
started looking at this, but I presume one of the ALSA developpers will have 
this minor issue fixed before I even found where to look :)

Jos

On Sunday 06 October 2002 07:06, Tim Spriggs wrote:
> I got this when I selected the alsa branch of the kernel configuration
>
> with kernel 2.5.40:
> | Menuconfig has encountered a possible error in one of the kernel's
> | configuration files and is unable to continue.  Here is the error
> | report:
> |
> |  Q> ./scripts/Menuconfig: line 823: MCmenu74: command not found
> |
> | Please report this to the maintainer <mec@shout.net>.  You may also
> | send a problem report to <linux-kernel@vger.kernel.org>.
> |
> | Please indicate the kernel version you are trying to configure and
> | which menu you were trying to enter when this error occurred.
> |
> | make: *** [menuconfig] Error 1
>
> If there is anything I can do to help fix this, let me know.
>
> -Tim
>
>                      < PRE >
> ##--##--##--##--##--##--##--##--##--##--##--##--##
>
> |             T I M    S P R I G G S             |
> |        Assistant Sysadmin - Development        |
> |        College of Engineering and Mines        |
> |            ECE206A - (520) 621-3185            |
>
> ##--##--##--##--##--##--##--##--##--##--##--##--##
>                      </PRE >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

