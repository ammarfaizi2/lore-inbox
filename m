Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130130AbQLDOde>; Mon, 4 Dec 2000 09:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbQLDOdZ>; Mon, 4 Dec 2000 09:33:25 -0500
Received: from wsa-245.sibintek.net ([213.128.193.245]:24608 "EHLO
	mail.ixcelerator.com") by vger.kernel.org with ESMTP
	id <S129730AbQLDOdJ>; Mon, 4 Dec 2000 09:33:09 -0500
Date: Mon, 4 Dec 2000 17:01:34 +0300
From: Oleg Drokin <green@ixcelerator.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race/problem with hotplug & network interfaces
Message-ID: <20001204170134.A12486@iXcelerator.com>
In-Reply-To: <20001204155751.B11731@iXcelerator.com> <3A2B9F2D.2A7A09E1@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A2B9F2D.2A7A09E1@uow.edu.au>; from andrewm@uow.edu.au on Tue, Dec 05, 2000 at 12:42:05AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Dec 05, 2000 at 12:42:05AM +1100, Andrew Morton wrote:

> Could you please test this patch?  It was sent to Linus for
> test12-pre4, but....
Yes, it works that way. 
But code path and readability became horrible, unfortunatelly. :(

Bye,
    Oleg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
