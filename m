Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289491AbSAJPPR>; Thu, 10 Jan 2002 10:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289488AbSAJPO6>; Thu, 10 Jan 2002 10:14:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289491AbSAJPOq>; Thu, 10 Jan 2002 10:14:46 -0500
Date: Thu, 10 Jan 2002 10:16:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "David S. Miller" <davem@redhat.com>
cc: david.balazic@uni-mb.si, matthias.andree@stud.uni-dortmund.de,
        linux-kernel@vger.kernel.org
Subject: Re: Simple local DOS
In-Reply-To: <20020110.065819.41634244.davem@redhat.com>
Message-ID: <Pine.LNX.3.95.1020110100953.5851A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, David S. Miller wrote:

>    From: "Richard B. Johnson" <root@chaos.analogic.com>
>    Date: Thu, 10 Jan 2002 09:07:51 -0500 (EST)
>    
>    Ctrl-ALT-F12 selects VT mode from a locked X-window, ALT-F1 gets you
>    to the first VT, ALT-F2, next, etc.
>    No problem at all.
> 
> Only if X services the keypress, in his case X is blocked on
> stdout/stderr output so it won't.
> 

I tried it before I answered the query. It works fine here. The
only problem I found is the VT that X was using ended up with
strange non-usable characteristics in graphics mode. The others
are fine and X can be killed, releasing its resources. Also,
CTL-Alt-Backspace works at least 50 percent of the time when
an attempt is made to lock it up as reported.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


