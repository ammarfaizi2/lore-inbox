Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265113AbSJaFhT>; Thu, 31 Oct 2002 00:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265179AbSJaFhS>; Thu, 31 Oct 2002 00:37:18 -0500
Received: from angband.namesys.com ([212.16.7.85]:5504 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265113AbSJaFhM>; Thu, 31 Oct 2002 00:37:12 -0500
Date: Thu, 31 Oct 2002 08:43:37 +0300
From: Oleg Drokin <green@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Torrey Hoffman <thoffman@arnor.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Mounting reiserfs with nonstandard journal size fails
Message-ID: <20021031084337.C1017@namesys.com>
References: <1035934581.1487.1409.camel@rivendell.arnor.net> <20021030093911.B5560@namesys.com> <3DC04F39.1030709@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3DC04F39.1030709@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Oct 31, 2002 at 12:29:29AM +0300, Hans Reiser wrote:
> >>I'm having trouble mounting a reiserfs filesystem created with a
> >>nonstandard (smaller) journal size.  But if I use the default journal
> >>size, it works fine.
> >Sure. Non-standard journal is only supported in 2.5 kernel for now.
> That should be in the queue for the next pre1, yes?

Yes. Also lots of other stuff which we, unfortunatelly have not
put in 2.5, too.

Bye,
    Oleg
