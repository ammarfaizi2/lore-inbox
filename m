Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130401AbRA3XnF>; Tue, 30 Jan 2001 18:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRA3Xmz>; Tue, 30 Jan 2001 18:42:55 -0500
Received: from [209.24.233.229] ([209.24.233.229]:16646 "HELO
	penguincomputing.com") by vger.kernel.org with SMTP
	id <S130922AbRA3Xmx>; Tue, 30 Jan 2001 18:42:53 -0500
Date: Tue, 30 Jan 2001 15:42:36 -0800 (PST)
From: "Brett G. Person" <bperson@penguincomputing.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Reiserfs problem was: Re: Version 2.4.1 cannot be built. 
In-Reply-To: <Pine.LNX.4.21.0101302012410.1321-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101301538520.22416-100000@mailserver.penguincomputing.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Worked fine here but  i am getting segfaults on my Reiser filesystems. 
I've been distracted by a project over the last few days. Is what I'm
seeing a symptom of the fs corruption people were talking about last week?

Brett G. Person
415-358-2656
bperson@penguincomputing.com

Penguin Computing - The World's Most Reliable Linux Systems

On Tue, 30 Jan 2001, Rik van Riel wrote:

> On Tue, 30 Jan 2001, Richard B. Johnson wrote:
> 
> > The subject says it all. `make dep` is now broken.
> 
> It worked fine here, with 2.4.1 unpacked from the tarball.
> 
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com.br/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
