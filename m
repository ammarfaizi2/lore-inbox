Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSD2Hds>; Mon, 29 Apr 2002 03:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314854AbSD2Hdr>; Mon, 29 Apr 2002 03:33:47 -0400
Received: from angband.namesys.com ([212.16.7.85]:27538 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S314690AbSD2Hdr>; Mon, 29 Apr 2002 03:33:47 -0400
Date: Mon, 29 Apr 2002 11:33:45 +0400
From: Oleg Drokin <green@namesys.com>
To: kuebelr@email.uc.edu
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: un-removable files on reiserfs
Message-ID: <20020429113345.A22574@namesys.com>
In-Reply-To: <20020427194019.GA898@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  Apparently there is a problem with your filesystem.
  Please get latest reiserfsprogs and run reiserfsck on your
  partition to see what's wrong with your fs.

Bye,
    Oleg
On Sat, Apr 27, 2002 at 03:40:19PM -0400, kuebelr@email.uc.edu wrote:
> i have a few files on a reiserfs disk that i cannot remove. they showed
> up sometime after i started using 2.4.17.  also, i haven't been able to
> find an oops in my ksymoops logs.
