Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264146AbSJ3Gcy>; Wed, 30 Oct 2002 01:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264210AbSJ3Gcy>; Wed, 30 Oct 2002 01:32:54 -0500
Received: from angband.namesys.com ([212.16.7.85]:31363 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S264146AbSJ3Gcx>; Wed, 30 Oct 2002 01:32:53 -0500
Date: Wed, 30 Oct 2002 09:39:11 +0300
From: Oleg Drokin <green@namesys.com>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Mounting reiserfs with nonstandard journal size fails
Message-ID: <20021030093911.B5560@namesys.com>
References: <1035934581.1487.1409.camel@rivendell.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1035934581.1487.1409.camel@rivendell.arnor.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Oct 29, 2002 at 03:36:20PM -0800, Torrey Hoffman wrote:
> I'm having trouble mounting a reiserfs filesystem created with a
> nonstandard (smaller) journal size.  But if I use the default journal
> size, it works fine.

Sure. Non-standard journal is only supported in 2.5 kernel for now.

Bye,
    Oleg
