Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317522AbSFKTf3>; Tue, 11 Jun 2002 15:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317523AbSFKTf2>; Tue, 11 Jun 2002 15:35:28 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:28432 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317522AbSFKTf1>; Tue, 11 Jun 2002 15:35:27 -0400
Date: Tue, 11 Jun 2002 21:34:56 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Jason C. Pion" <jpion@valhalla.homelinux.org>
Cc: Nick Evgeniev <nick@octet.spb.ru>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
Message-ID: <20020611193456.GC9431@louise.pinerecords.com>
In-Reply-To: <002101c2115d$1c0bc7c0$baefb0d4@nick> <Pine.LNX.4.44.0206111243560.2457-100000@valhalla.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 7 days, 6:20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It sounds to me like you've got some flakey hardware.  Don't try to save 
> the rest of us.  I've been using the Promise drivers with my Ultra 133TX2 
> for quite a while now and haven't had _ANY_ problems with it.

Yup, with the exception of the "have to boot with ide2=ata66 to get udma
3/4/5 to work" bug, it seems to work perfectly.

T.
