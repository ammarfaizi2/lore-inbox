Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSDSNCH>; Fri, 19 Apr 2002 09:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312459AbSDSNCG>; Fri, 19 Apr 2002 09:02:06 -0400
Received: from 127.141.hh1.ip.foni.net ([212.7.141.127]:1796 "HELO
	debian.heim.lan") by vger.kernel.org with SMTP id <S312457AbSDSNCF>;
	Fri, 19 Apr 2002 09:02:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian Schoenebeck <christian.schoenebeck@epost.de>
To: brian@worldcontrol.com
Subject: Re: power off (again)
Date: Fri, 19 Apr 2002 14:56:00 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020418201220.C6D6247B1@debian.heim.lan> <20020419045648.GA2104@top.worldcontrol.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020419122807.319D647B1@debian.heim.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 19. April 2002 06:56 schrieb brian@worldcontrol.com:
> On Thu, Apr 18, 2002 at 10:40:06PM +0200, Christian Schoenebeck wrote:
> > I'm still fighting the problem that power off doesn't work with one of
> > our machines since moving from 2.2.19 to 2.4.7 kernel.
>
> I have no idea if this will help but most of my systems have
>
> append="apm=power-off"
>
> in their lilo config.

And ours append="apm=on", but I also tried apm=power-off - didn't help
