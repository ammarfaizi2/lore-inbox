Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSGLVZR>; Fri, 12 Jul 2002 17:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318019AbSGLVZQ>; Fri, 12 Jul 2002 17:25:16 -0400
Received: from pD9E235D3.dip.t-dialin.net ([217.226.53.211]:65158 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318018AbSGLVZP>; Fri, 12 Jul 2002 17:25:15 -0400
Date: Fri, 12 Jul 2002 15:27:25 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Rob Landley <landley@trommello.org>
cc: linux-kernel@vger.kernel.org, <marcelo@connectiva.com.br>
Subject: Re: No rule to make autoconf.h in 2.4.19-rc1?
In-Reply-To: <20020712205136.8D3648B5@merlin.webofficenow.com>
Message-ID: <Pine.LNX.4.44.0207121526421.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, Rob Landley wrote:
> What does the kernel use autoconf for?  (When did this get added?  I wrote a 
> kernel output parser and didn't see autoconf, and I'd expect it to run in ake 
> dep anyway...)

This is your kernel configuration. Please run make 
configure/oldconfig/menuconfig before running make dep.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

