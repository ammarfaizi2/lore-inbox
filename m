Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311572AbSDDUdU>; Thu, 4 Apr 2002 15:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311582AbSDDUdL>; Thu, 4 Apr 2002 15:33:11 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1033 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311572AbSDDUc7>; Thu, 4 Apr 2002 15:32:59 -0500
Date: Thu, 4 Apr 2002 16:28:14 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Tom Holroyd <tomh@po.crl.go.jp>
Cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5
In-Reply-To: <Pine.LNX.4.44.0204041802310.549-100000@holly.crl.go.jp>
Message-ID: <Pine.LNX.4.21.0204041627580.10117-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could you please try to reproduce with 2.4.19-pre4 ?

Thanks

On Thu, 4 Apr 2002, Tom Holroyd wrote:

> AlphaPC 264DP 666 MHz (Tsunami, UP)
> 1GB RAM
> gcc version 3.0.3
> 
> Running stuff as usual, reading large files, I can often get
> very long mouse freezes when redrawing a certain window in X after
> leaving it for a while.  I never saw this behavior in 2.4.18-rc1,
> which I ran for over 1 month doing the same stuff.  vmstat doesn't
> report swapping activity that I can see, just a window that should
> refresh (no backing store) right away causes long (2~5 sec) freezes.


