Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293201AbSBWUga>; Sat, 23 Feb 2002 15:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293202AbSBWUgU>; Sat, 23 Feb 2002 15:36:20 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:29167
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293201AbSBWUgL>; Sat, 23 Feb 2002 15:36:11 -0500
Date: Sat, 23 Feb 2002 12:36:34 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Gunther Mayer <gunther.mayer@gmx.net>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Adam Huffman <bloch@verdurin.com>, linux-kernel@vger.kernel.org
Subject: Re: Boot problem with PDC20269
Message-ID: <20020223203634.GL20060@matchmail.com>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Gunther Mayer <gunther.mayer@gmx.net>,
	Andre Hedrick <andre@linuxdiskcert.org>,
	Adam Huffman <bloch@verdurin.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020223201827.GK20060@matchmail.com> <Pine.LNX.4.30.0202232132280.13662-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0202232132280.13662-100000@mustard.heime.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 09:33:02PM +0100, Roy Sigurd Karlsbakk wrote:
> > > A fix would be to printk("The linux IDE driver does not (yet?)support ATAPI
> > > devices on PDC20269. Ignoring the device.\n");
> > > and continue running.
> 
> er .. I'm running a PDC20269 with a few drives. Is that supposed to be
> impossible?
> 

Are they ATAPI drives (cdrom, etc)?
