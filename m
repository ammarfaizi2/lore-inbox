Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbTAAUSH>; Wed, 1 Jan 2003 15:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbTAAUSH>; Wed, 1 Jan 2003 15:18:07 -0500
Received: from [81.2.122.30] ([81.2.122.30]:31752 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264010AbTAAUSG>;
	Wed, 1 Jan 2003 15:18:06 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301012026.h01KQJq9002327@darkstar.example.net>
Subject: Re: observations on 2.5 config screens
To: szepe@pinerecords.com (Tomas Szepe)
Date: Wed, 1 Jan 2003 20:26:18 +0000 (GMT)
Cc: rpjday@mindspring.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030101200717.GA17053@louise.pinerecords.com> from "Tomas Szepe" at Jan 01, 2003 09:07:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Multimedia devices
> > 
> >     How come "Sound" is not here?  And (as we've already
> >   established), Radio Adapters is not a sub-entry of Video for
> >   Linux. :-)  (And is there a reason why Amateur Radio Support
> >   and Radio Adapters are so far apart in the config menus?
> 
> Yeah, this one is a puzzle. <g>

Amateur Radio Support contains options to do with things like ham
radio modem support.

Radio Adaptors contains options to do with radio tuner cards.

Radio adaptors was originally put together with Video for Linux,
because when there were only a few radio adaptors supported, it seemed
logical to group them with video capture cards, which often have
television tuners on them.

Most of the illogical grouping of configuration options has come about
because of the way the kernel has evolved.

For example, before IDE and SCSI CD-ROM drives because popular, CD-ROM
drives were a completely separate configuration category.  Now that
IDE and SCSI CD-ROM drives are much more popular than proprietary
interface CD-ROM drives, the configuration options for them are
grouped with the IDE and SCSI options.

John.
