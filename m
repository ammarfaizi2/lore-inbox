Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310597AbSCMN6y>; Wed, 13 Mar 2002 08:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310601AbSCMN6o>; Wed, 13 Mar 2002 08:58:44 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:61190 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310597AbSCMN6a>;
	Wed, 13 Mar 2002 08:58:30 -0500
Date: Wed, 13 Mar 2002 10:58:20 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Peter Zaitsev <pz@spylog.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MMAP vs READ/WRITE
In-Reply-To: <861732271654.20020313161718@spylog.ru>
Message-ID: <Pine.LNX.4.44L.0203131058060.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Peter Zaitsev wrote:

>   So I would say mmap is not really optimized nowdays in Linux and so
>   read() may be wining in cases it should not. May be read-ahead is
>   used with read and is not used with mmap.

Both guesses are correct.

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

