Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267154AbUBMSeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUBMSdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:33:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267167AbUBMSbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:31:55 -0500
Date: Fri, 13 Feb 2004 13:31:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
In-Reply-To: <20040213181542.GD8858@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.53.0402131325470.1895@chaos>
References: <1076604650.31270.20.camel@ulysse.olympe.o2t>
 <20040213030346.GF25499@mail.shareable.org> <1076695606.23795.23.camel@m222.net81-64-248.noos.fr>
 <20040213181542.GD8858@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Fri, Feb 13, 2004 at 07:06:46PM +0100, Nicolas Mailhot wrote:
> > And as for the filename problems :
> > - just mangle existing invalid filenames when a default encoding is
> > agreed upon
> > - refuse to write new files with invalid filenames just like you would
> > with the few names forbidden in ascii - apps will learn to cope.
>
> What names forbidden in ASCII?

I think that all ASCII characters below 0x20 are forbidden in
Unix file-names and others shown in the reference cited and
"disapproved".

http://www.med.nyu.edu/rcr/rcr/nyu_vms/unixfileanddirectorynames.htm


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


