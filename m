Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRCFV16>; Tue, 6 Mar 2001 16:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129517AbRCFV1i>; Tue, 6 Mar 2001 16:27:38 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:22028
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129506AbRCFV1d>; Tue, 6 Mar 2001 16:27:33 -0500
Date: Tue, 6 Mar 2001 13:26:07 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "James A. Sutherland" <jas88@cam.ac.uk>
cc: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Microsoft ZERO Sector Virus, Result of Taskfile WAR
In-Reply-To: <Pine.LNX.4.30.0103062119420.9088-100000@dax.joh.cam.ac.uk>
Message-ID: <Pine.LNX.4.10.10103061324540.13719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, James A. Sutherland wrote:

> > Jens we are not going there....the filter is the only way known to jam
> > unknown commands,
> 
> Erm... the hoax "virus" was about writing to the first sector of the disk,
> overriding the partition table. If "write data" is an "unknown command",
> HTF am I supposed to store data on my HDD? :P

One-liner: It is stupid to issue a data-command using a non-data-handler.

Andre Hedrick
Linux ATA Development

