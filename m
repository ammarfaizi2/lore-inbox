Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282723AbRK0Bph>; Mon, 26 Nov 2001 20:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282724AbRK0Bp1>; Mon, 26 Nov 2001 20:45:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:59756 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282723AbRK0BpQ>; Mon, 26 Nov 2001 20:45:16 -0500
Date: Tue, 27 Nov 2001 02:45:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Nathan G. Grennan" <ngrennan@okcforum.org>, linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011127024517.A1465@athlon.random>
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org> <E168U3m-00077F-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E168U3m-00077F-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 26, 2001 at 10:17:06PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 10:17:06PM +0000, Alan Cox wrote:
> > 2.4.16 becomes very unresponsive for 30 seconds or so at a time during
> > large unarchiving of tarballs, like tar -zxf mozilla-src.tar.gz. The
> > file is about 36mb. I run top in one window, run free repeatedly in
> 
> This seems to be one of the small as yet unresolved problems with the newer
> VM code in 2.4.16. I've not managed to prove its the VM or the differing

can you reproduce on 2.4.15aa1?

Andrea
