Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbSJNPRU>; Mon, 14 Oct 2002 11:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbSJNPRU>; Mon, 14 Oct 2002 11:17:20 -0400
Received: from greenie.frogspace.net ([64.6.248.2]:43751 "EHLO
	greenie.frogspace.net") by vger.kernel.org with ESMTP
	id <S261819AbSJNPRT>; Mon, 14 Oct 2002 11:17:19 -0400
Date: Mon, 14 Oct 2002 08:23:08 -0700 (PDT)
From: Peter <cogwepeter@cogweb.net>
X-X-Sender: cogwepeter@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: Re: Known 'issues' about 2.4.19...
In-Reply-To: <Pine.LNX.4.44.0209221038300.21911-100000@greenie.frogspace.net>
Message-ID: <Pine.LNX.4.44.0210140805400.23844-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul,

You might want to try 2.4.19-ac4, the latest -ac revision to the stable
kernel. I've run this for a couple of months now with one single incident
-- on playing a lot of divx files with mplayer, the machine ran out of
memory and started swapping feverishly. The system froze for a minute and
then let up. Some mm issue. I'm running a DVD player and burner, a 160GB
drive on a x69 Promise card and mount external drives through NFS and
Samba, on ext3, Intel chipsets, firewire stuff -- as stable as 2.4.16 with
more features. I've been working with 20GB files with no problems. I
should say this is not my web and file server; that is still running
2.4.16, as it doesn't need the new features.

The most recent -ac kernels are likely fine too, but there appear to be
some residual ide and ide-scsi issues (could be minor) and Andre is off
fishing. 

Cheers,
Peter


