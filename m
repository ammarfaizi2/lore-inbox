Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbSJPWeW>; Wed, 16 Oct 2002 18:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbSJPWeW>; Wed, 16 Oct 2002 18:34:22 -0400
Received: from 62-190-219-130.pdu.pipex.net ([62.190.219.130]:36613 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261729AbSJPWeW>; Wed, 16 Oct 2002 18:34:22 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210162248.g9GMmtVn000591@darkstar.example.net>
Subject: Re: Linux v2.5.43
To: axboe@suse.de (Jens Axboe)
Date: Wed, 16 Oct 2002 23:48:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021016073154.GF4827@suse.de> from "Jens Axboe" at Oct 16, 2002 09:31:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A huge merging frenzy for the feature freeze, although I also spent a few
> > days getting rid of the need for ide-scsi.c and the SCSI layer to burn
> > CD-ROM's with the IDE driver (it still needs an update to cdrecord, I sent 
> > those off to the maintainer).
> 
> I put cdrecord rpms up here:
> 
> *.kernel.org/pub/linux/kernel/people/axboe/tools
> 
> The binary rpms are built on SuSE 8.1, there's a source rpm there too
> though. This is 1.11a37 with Linus patch that allows you do to
> 
> 	cdrecord -dev=/dev/hdc -data -....
> 
> and burn without die-scsi.

Is die-scsi a typo, or a description of the success of ide-scsi?  :-)

John.
