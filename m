Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291839AbSBAQeP>; Fri, 1 Feb 2002 11:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291836AbSBAQeE>; Fri, 1 Feb 2002 11:34:04 -0500
Received: from dns.logatique.fr ([213.41.101.1]:7671 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S291837AbSBAQdz>; Fri, 1 Feb 2002 11:33:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: VESA Anybody out there
Date: Fri, 1 Feb 2002 17:33:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202011640070.2501-100000@unicef.org.yu> <3C5AC078.8010103@evision-ventures.com>
In-Reply-To: <3C5AC078.8010103@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020201163119.6ED6323CBB@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Do I have to understand that you're using : "vga=ask scan" ?
this can't work, cause it doesn't mean anything.

The syntax is "vga=ask" _or_ "vga=scan"

Or, if you prefer, 'ask' is a special scan code you can put, that will ask 
you (at boot time) which one you want (you'll get a list of scancode 
supported by your graphic card to choose from)


best wishes,
Thomas

On Friday 01 February 2002 17:21, Martin Dalecki wrote:
> Davidovac Zoran wrote:
> >kernel 2.2.X ati rage,ati radeon vga=ask works (as vesa)
> >kernel 2.4.X 800x600 mode didn't tested vga=ask
>
> I really mean the "scan" command after VGA ask.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
