Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130071AbRCAWiV>; Thu, 1 Mar 2001 17:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbRCAWiM>; Thu, 1 Mar 2001 17:38:12 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1028 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S130071AbRCAWhv>; Thu, 1 Mar 2001 17:37:51 -0500
Date: Thu, 1 Mar 2001 17:51:43 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Evans <chris@scary.beasts.org>
Cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.30.0103012232040.21550-100000@ferret.lmh.ox.ac.uk>
Message-ID: <Pine.LNX.4.21.0103011751010.8305-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Mar 2001, Chris Evans wrote:

> 
> On Thu, 1 Mar 2001, Rik van Riel wrote:
> 
> > True. I think we want something in-between our ideas...
>         ^^^^^^^
> > a while. This should make it possible for the disk reads to
>                 ^^^^^^
> 
> Oh dear.. not more "vm design by waving hands in the air". Come on people,
> improve the vm by careful profiling, tweaking and benching, not by
> throwing random patches in that seem cool in theory.

OTOH, "careful profiling, tweaking and benching" are always limited to a
number workloads.



