Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318866AbSG0XdE>; Sat, 27 Jul 2002 19:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318867AbSG0XdE>; Sat, 27 Jul 2002 19:33:04 -0400
Received: from dsl-213-023-021-146.arcor-ip.net ([213.23.21.146]:55936 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318866AbSG0XdE>;
	Sat, 27 Jul 2002 19:33:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Buddy Lumpkin" <b.lumpkin@attbi.com>,
       "Rik van Riel" <riel@conectiva.com.br>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: About the need of a swap area
Date: Sun, 28 Jul 2002 01:36:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Austin Gonyou" <austin@digitalroadkill.net>,
       <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Ville Herva" <vherva@niksula.hut.fi>, "DervishD" <raul@pleyades.net>,
       "Linux-kernel" <linux-kernel@vger.kernel.org>
References: <FJEIKLCALBJLPMEOOMECEEPICPAA.b.lumpkin@attbi.com>
In-Reply-To: <FJEIKLCALBJLPMEOOMECEEPICPAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Yb6z-0001TO-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 July 2002 00:49, Buddy Lumpkin wrote:
> They implemented a new system that still tends to give preference to
> filesystem pages called a cyclical page cache. I haven't seen any
> whitepapers on how it works though.

This is fairly informative:

   http://www.princeton.edu/~unix/Solaris/troubleshoot/ram.html

-- 
Daniel
