Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130064AbRCAWfv>; Thu, 1 Mar 2001 17:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130065AbRCAWfo>; Thu, 1 Mar 2001 17:35:44 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:53515 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S130064AbRCAWfd>; Thu, 1 Mar 2001 17:35:33 -0500
Date: Thu, 1 Mar 2001 22:35:29 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0103011747560.1961-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0103012232040.21550-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Mar 2001, Rik van Riel wrote:

> True. I think we want something in-between our ideas...
        ^^^^^^^
> a while. This should make it possible for the disk reads to
                ^^^^^^

Oh dear.. not more "vm design by waving hands in the air". Come on people,
improve the vm by careful profiling, tweaking and benching, not by
throwing random patches in that seem cool in theory.

Cheers
Chris

