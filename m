Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280907AbRKYQWn>; Sun, 25 Nov 2001 11:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280917AbRKYQWd>; Sun, 25 Nov 2001 11:22:33 -0500
Received: from think.faceprint.com ([166.90.149.11]:57020 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S280907AbRKYQWV>; Sun, 25 Nov 2001 11:22:21 -0500
From: Nathan Walp <faceprint@think.faceprint.com>
Date: Sun, 25 Nov 2001 11:23:32 -0500
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: John Alvord <jalvo@mbay.net>, David Relson <relson@osagesoftware.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel Releases
Message-ID: <20011125112332.A13505@think.faceprint.com>
In-Reply-To: <Pine.LNX.4.20.0111242147500.26049-100000@otter.mbay.net> <m1d726zwdm.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d726zwdm.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Correctness means you can write a proof showing how it meats it's
> specifications.  Stability means something passes the test of time.
                                             ^^^^^^^^^^^^^^^^^^^^^^^
I think you hit the nail on the head here.  2.<even>.x kernels are not
stable, they are presumably stable.  Nothing is stable until it proves
itself.

If you run a hours-old kernel on a production machine, you will get
burned sooner or later.  If you run an hours-old kernel on a production
machine, and manage to reboot it so quickly, I start to wonder what kind
of "production" you're running.

Nathan
