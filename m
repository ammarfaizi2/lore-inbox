Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSEaTlJ>; Fri, 31 May 2002 15:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSEaTlI>; Fri, 31 May 2002 15:41:08 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:57728 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S316659AbSEaTlH>; Fri, 31 May 2002 15:41:07 -0400
Date: Fri, 31 May 2002 21:46:13 +0200
Organization: Pleyades
To: dent@cosy.sbg.ac.at, linux-kernel@vger.kernel.org
Subject: Re: do_mmap
Message-ID: <3CF7D305.mail9T111HCUL@viadomus.com>
In-Reply-To: <Pine.GSO.4.05.10205311456070.10633-100000@mausmaki.cosy.sbg.ac.at>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello Thomas :)

>is it possible to have 0 as a valid address? - if not, this should
>be the return on errors.

    It is possible. I've sent a patch about it but really returning 0
sometimes is the desired behaviour ;)

    Raúl
