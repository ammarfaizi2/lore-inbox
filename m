Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSHOUvw>; Thu, 15 Aug 2002 16:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSHOUvw>; Thu, 15 Aug 2002 16:51:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:45842 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317427AbSHOUvv>; Thu, 15 Aug 2002 16:51:51 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208152054.g7FKsif02357@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-pre2-ac3
To: bunk@fs.tum.de (Adrian Bunk)
Date: Thu, 15 Aug 2002 16:54:44 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), kai.germaschewski@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0208152235040.1351-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Aug 15, 2002 10:49:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linux 2.4.20-pre2-ac2
> >...
> > o	Tweak isdn to try and fix gcc 2.95 compile 	(Kai Germaschewski)
> >...
> 
> Compilation of 2.4.20-pre2-ac3 fails:

Ok fixed the ifdef way to handle the old cpp problems then
