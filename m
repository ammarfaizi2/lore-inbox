Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTAQLDr>; Fri, 17 Jan 2003 06:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTAQLCe>; Fri, 17 Jan 2003 06:02:34 -0500
Received: from [66.70.28.20] ([66.70.28.20]:62471 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267489AbTAQLCa>; Fri, 17 Jan 2003 06:02:30 -0500
Date: Fri, 17 Jan 2003 11:50:30 +0100
From: DervishD <raul@pleyades.net>
To: Linux Geek <bourne@toughguy.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tar'ing /proc ???
Message-ID: <20030117105030.GE47@DervishD>
References: <3E26BB8D.7070601@ToughGuy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E26BB8D.7070601@ToughGuy.net>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Linux Geek :)

> I have been getting strange errors when i was trying to tar my /proc . 
> Are there any known issues/problems when we do such a thing ?

    Yes, the files under the procfs are *not* real files. I don't think
that taring /proc/kcore is a good idea, for example ;))

> Is it supposed to work at all ?

    Don't think so.
 
> There is no reason as to why i am doing this :-) , just wanted to try out.
 
    ;))) Do any try you want with linux: if you don't do it as root,
you won't damage anything :))

    Raúl
