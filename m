Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbSJaHPJ>; Thu, 31 Oct 2002 02:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265208AbSJaHPJ>; Thu, 31 Oct 2002 02:15:09 -0500
Received: from mail.gurulabs.com ([208.177.141.7]:33960 "EHLO
	mail.gurulabs.com") by vger.kernel.org with ESMTP
	id <S265205AbSJaHPH>; Thu, 31 Oct 2002 02:15:07 -0500
Subject: Re: What's left over.
From: Dax Kelson <dax@gurulabs.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Chris Wedgwood <cw@f00f.org>, Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0210310203570.13031-100000@weyl.math.psu.edu>
References: <Pine.GSO.4.21.0210310203570.13031-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 00:21:34 -0700
Message-Id: <1036048895.1522.7.camel@mentor>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 00:10, Alexander Viro wrote:
> 
> 
> On 30 Oct 2002, Dax Kelson wrote:
> 
> > Without ACLs, if Sally, Joe and Bill need rw access to a file/dir, just
> > create another group with just those three people in.  Over time, of
> 
> If Sally, Joe and Bill need rw access to a directory, and Joe and Bill
> are using existing userland (any OS I'd seen), then Sally can easily
> fuck them into the next month and not in a good way.

I think the normal intent is to let Sally, Joe, and Bill have their own
private directory protected from THE REST OF THE USERS.

If a member of your trusted circle goes rogue, then, yup you are screwed
for the moment. It shouldn't last a whole month though.

That is what backups, and employment termination is for.

Dax

