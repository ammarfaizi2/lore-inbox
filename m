Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269547AbRGaXx3>; Tue, 31 Jul 2001 19:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269546AbRGaXxT>; Tue, 31 Jul 2001 19:53:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55565 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269549AbRGaXxR>; Tue, 31 Jul 2001 19:53:17 -0400
Date: Tue, 31 Jul 2001 20:53:22 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Chris Wedgwood <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010801114635.C8839@weta.f00f.org>
Message-ID: <Pine.LNX.4.33L.0107312052460.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 1 Aug 2001, Chris Wedgwood wrote:
> On Tue, Jul 31, 2001 at 11:29:47PM +0200, Matthias Andree wrote:
>
>     If I understand SUS v2 correctly, fsync() must sync meta data
>     corresponding to the file.
>
>     If Linux ext2 doesn't to that, it might be a good idea to change
>     that so it does.
>
> Define 'meta-data' --- linux sync's any inode and/or bitmap
> changes, fsyn on a file will ensure it is intact but not that it
> can't get lost.

Syntactically correct, but quite useless IMHO ;)

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

