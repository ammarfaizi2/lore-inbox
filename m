Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312773AbSDKSyb>; Thu, 11 Apr 2002 14:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312797AbSDKSya>; Thu, 11 Apr 2002 14:54:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34827 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312773AbSDKSy3>; Thu, 11 Apr 2002 14:54:29 -0400
Date: Thu, 11 Apr 2002 15:54:09 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, <wli@holomorphy.com>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <Pine.LNX.4.44L.0204111522000.31387-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44L.0204111553020.31387-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, Rik van Riel wrote:

> replace slightly obscure while loops with for_each_zone and
> for_each_pgdat macros  (thanks to William Lee Irwin)

OK, please skip this patch...

William Irwin just found a bug in his code which is
kind of bad for some, if not all, discontigmem machines.

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

