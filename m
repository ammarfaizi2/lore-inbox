Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318778AbSIHOCD>; Sun, 8 Sep 2002 10:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319607AbSIHOCD>; Sun, 8 Sep 2002 10:02:03 -0400
Received: from 62-190-217-197.pdu.pipex.net ([62.190.217.197]:47621 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S318778AbSIHOCC>; Sun, 8 Sep 2002 10:02:02 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209081414.g88EELZK002695@darkstar.example.net>
Subject: Re: ide drive dying?
To: linux-kernel@vger.kernel.org
Date: Sun, 8 Sep 2002 15:14:20 +0100 (BST)
In-Reply-To: <alfaco$3u0$1@forge.intermeta.de> from "Henning P. Schmiedehausen" at Sep 08, 2002 10:56:24 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >The firmware update is for many more drives than that, My own
> 
> >     Model=IBM-DTLA-305040, FwRev=TW4OA60A
> 
> >is also recommended, as well as many with a FwRev=xxxOyzzz with zzz<66A.
> >Now i have to find a windows machine to try it out on...
> 
> You don't need to. All you need is someone run this tool and send you
> the image it creates. I put mine as boot.img on a CD so I can upgrade
> all the disks I have in boxes without floppy disk drives. It's a self
> booting DOS disk.

As the old firmware is known to be buggy, and those bugs are relevant when using Linux, and updated firmware is available, is it worth checking for the known buggy firmware version in the ide driver?

I realise that we cannot check every drive in the world for compatibility, but if this is a known issue...

John.
