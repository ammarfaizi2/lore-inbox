Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSKDWqj>; Mon, 4 Nov 2002 17:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262827AbSKDWqj>; Mon, 4 Nov 2002 17:46:39 -0500
Received: from almesberger.net ([63.105.73.239]:16649 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262826AbSKDWqi>; Mon, 4 Nov 2002 17:46:38 -0500
Date: Mon, 4 Nov 2002 19:52:29 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rob Landley <landley@trommello.org>
Cc: dcinege@psychosis.com, andersen@codepoet.org,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Message-ID: <20021104195229.C1407@almesberger.net>
References: <200210272017.56147.landley@trommello.org> <20021030085149.GA7919@codepoet.org> <200210300455.21691.dcinege@psychosis.com> <200211011917.16978.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211011917.16978.landley@trommello.org>; from landley@trommello.org on Mon, Nov 04, 2002 at 02:13:20AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> Yeah, cpio is a pain and change to use, but so is tar.

Somebody who strogly dislikes cpio could just write wrapper accepting
tar-style options. Or add a --cpio option to GNU tar, that switches
to using the cpio format. One could even try to auto-detect the
format when reading :-)

- Werner (hates cpio, but not enough)

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
