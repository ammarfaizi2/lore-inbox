Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317483AbSGEPk3>; Fri, 5 Jul 2002 11:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317493AbSGEPk2>; Fri, 5 Jul 2002 11:40:28 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:13832 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317483AbSGEPk0>; Fri, 5 Jul 2002 11:40:26 -0400
Date: Fri, 5 Jul 2002 12:40:41 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Mauricio Pretto <pretto@interage.com.br>
cc: Lista Kernel <linux-kernel@vger.kernel.org>, <hahn@physics.mcmaster.ca>,
       <rudmer@legolas.dynup.net>
Subject: Re: 2.5.24 - Swap Problem?
In-Reply-To: <3D25A5BA.7030904@interage.com.br>
Message-ID: <Pine.LNX.4.44L.0207051240170.8346-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002, Mauricio Pretto wrote:

> I have done this and it steel keep 0 mbs of free Swap used
> like this
>               total       used       free     shared    buffers     cached
> Mem:        182808     178328       4480          0       7544      83744
> -/+ buffers/cache:      87040      95768
> Swap:       136512          0     136512
> Its very strange my box almoust hangup

Could you show us some output of 'vmstat 1' while your
system is behaving badly ?

thank you,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

