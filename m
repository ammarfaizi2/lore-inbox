Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRBVUgQ>; Thu, 22 Feb 2001 15:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129382AbRBVUgH>; Thu, 22 Feb 2001 15:36:07 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:38962 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129375AbRBVUfz>; Thu, 22 Feb 2001 15:35:55 -0500
Date: Thu, 22 Feb 2001 14:32:17 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac1
In-Reply-To: <Pine.NEB.4.33.0102221729550.25273-100000@gaia.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.3.96.1010222143120.4774E-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, Adrian Bunk wrote:
> Hi Alan,
> 
> is it possible that you send a list of all the changes in 2.4.2ac1
> compared to plain 2.4.2?

I doubt Alan has time for requests like this (but more power to him, if
he does)...

His patch is diff'd against 2.4.2, so just look at the patch.  I do this
for a quick summary of files changes:

bzgrep '^--- linux' alans-patch.bz2 | less


