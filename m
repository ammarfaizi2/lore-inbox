Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIBzl>; Mon, 8 Jan 2001 20:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAIBzU>; Mon, 8 Jan 2001 20:55:20 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:46903 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129226AbRAIBzT>; Mon, 8 Jan 2001 20:55:19 -0500
Date: Tue, 9 Jan 2001 02:55:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Benson Chow <blc@q.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010109025515.S27646@athlon.random>
In-Reply-To: <20010108225451.A968@stefan.sime.com> <Pine.LNX.4.31.0101081501560.10554-100000@q.dyndns.org> <20010108203722.B10936@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010108203722.B10936@animx.eu.org>; from wakko@animx.eu.org on Mon, Jan 08, 2001 at 08:37:22PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 08:37:22PM -0500, Wakko Warner wrote:
> [wakko@<removed>:/home/wakko/test] rmdir "`pwd`"
> rmdir: /home/wakko/test: Invalid argument

Some other OS with a yet different retval? :)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
