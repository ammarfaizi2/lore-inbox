Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285322AbRLSP0h>; Wed, 19 Dec 2001 10:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285325AbRLSP00>; Wed, 19 Dec 2001 10:26:26 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:44297 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285322AbRLSP0M>; Wed, 19 Dec 2001 10:26:12 -0500
Date: Wed, 19 Dec 2001 18:26:06 +0300
From: Oleg Drokin <green@namesys.com>
To: Masaru Kawashima <masaruk@gol.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, chris@suse.de
Subject: Re: [reiserfs-list] reiserfs remount problem (Re: Linux 2.4.17-rc2)
Message-ID: <20011219182606.B29183@namesys.com>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva> <20011219230812.049c2c5c.masaruk@gol.com> <20011219172644.A28692@namesys.com> <20011219235203.322a02e3.masaruk@gol.com> <20011219180100.A28971@namesys.com> <20011220002117.6b660fa0.masaruk@gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011220002117.6b660fa0.masaruk@gol.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Dec 20, 2001 at 12:21:17AM +0900, Masaru Kawashima wrote:

> > Ok, I still want the metadata from this partition (read man on debugreiserfsck on -p option),
> > and tell me you reiserfsutils version.
> Ok, I'll try that tomorrow.
> (In Japan, it's midnight.  I want to go to sleep now.)
Good night, then.

> > Also were there any reiserfs specific error messages prior to the oops?
> There was no error message from reiserfs.
This is suspicious, because there is reiserfs_warning call in call trace you've sent us.

Bye,
    Oleg
