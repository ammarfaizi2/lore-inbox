Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261670AbSJMT4q>; Sun, 13 Oct 2002 15:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261672AbSJMT4q>; Sun, 13 Oct 2002 15:56:46 -0400
Received: from f123.law8.hotmail.com ([216.33.241.123]:33547 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261670AbSJMT4p>;
	Sun, 13 Oct 2002 15:56:45 -0400
X-Originating-IP: [24.44.249.150]
From: "sean darcy" <seandarcy@hotmail.com>
To: acme@conectiva.com.br
Cc: hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: VIA KT400 & VT8235 support
Date: Sun, 13 Oct 2002 16:02:31 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F123pst98dt23gQH9Jw00017349@hotmail.com>
X-OriginalArrivalTime: 13 Oct 2002 20:02:31.0975 (UTC) FILETIME=[770CEB70:01C272F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK. From lspic:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b168

from lspci -n:

00:00.0 Class 0600: 1106:3189
00:01.0 Class 0604: 1106:b168

So I take 1106:3189 and 1106:b168  and stick them where?

jay

>From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
.............
>Em Sat, Oct 12, 2002 at 10:11:05PM -0400, sean darcy escreveu:
> > Do you mean I can just stick a PCI id (where do I find it?) in some 
>table
> > (filename?)? How?
>
>lspci
>lspci -n
>
>- Arnaldo




_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

