Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSBYUHg>; Mon, 25 Feb 2002 15:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSBYUGs>; Mon, 25 Feb 2002 15:06:48 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:64530 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S287204AbSBYUGB>; Mon, 25 Feb 2002 15:06:01 -0500
Date: Mon, 25 Feb 2002 15:57:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18
In-Reply-To: <Pine.LNX.4.21.0202251537080.31438-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0202251556140.31438-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, DAMN. I missed the -rc4 patch in 2.4.18. Real sorry about that.

2.4.19-pre1 will contain it. 

On Mon, 25 Feb 2002, Marcelo Tosatti wrote:

> 
> Hi, 
> 
> Finally, 2.4.18. No changes between it and -rc4.
> 
> 
> final:
> 
> - No changes have been made between -final 
>   and -rc4.
> 
> rc4:
> 
> - Load code did not set personality for
>   binaries without an interpreter: This was 
>   breaking static apps on several archs		(Tom Gall)


