Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135551AbRANVy2>; Sun, 14 Jan 2001 16:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135567AbRANVyR>; Sun, 14 Jan 2001 16:54:17 -0500
Received: from innerfire.net ([208.181.73.33]:52231 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S135551AbRANVyG>;
	Sun, 14 Jan 2001 16:54:06 -0500
Date: Sun, 14 Jan 2001 13:54:38 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.30.0101142136330.4111-100000@e2>
Message-ID: <Pine.LNX.4.10.10101141349210.11765-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001, Ingo Molnar wrote:

> 
> On 14 Jan 2001, Linus Torvalds wrote:
> 
> > Does anybody but apache actually use it?
> 
> There is a Samba patch as well that makes it sendfile() based. Various
> other projects use it too (phttpd for example), some FTP servers i
> believe, and khttpd and TUX.

Proftpd to name one ftp server, nice little daemon uses linux-privs too.

	Gerhard

PS I wish someone would explain to me why distros insist on using WU
instead given it's horrid security record. 


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
