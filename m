Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbSKEAGv>; Mon, 4 Nov 2002 19:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbSKEAGV>; Mon, 4 Nov 2002 19:06:21 -0500
Received: from almesberger.net ([63.105.73.239]:18953 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262911AbSKEAFI>; Mon, 4 Nov 2002 19:05:08 -0500
Date: Mon, 4 Nov 2002 20:22:04 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Rob Landley <landley@trommello.org>, dcinege@psychosis.com,
       andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Message-ID: <20021104202204.C1408@almesberger.net>
References: <200210272017.56147.landley@trommello.org> <20021030085149.GA7919@codepoet.org> <200210300455.21691.dcinege@psychosis.com> <200211011917.16978.landley@trommello.org> <20021104195229.C1407@almesberger.net> <3DC6FC7C.7080105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC6FC7C.7080105@pobox.com>; from jgarzik@pobox.com on Mon, Nov 04, 2002 at 06:02:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Well, FWIW, "pax" deprecates both cpio and tar.

Well, pax is cute, particular the name, but it's just the internal
engine, with yet another incompatible interface :-( Of course, a
tar-to-cpio wrapper could use pax as an alternative to cpio ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
