Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTK2WoU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 17:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTK2WoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 17:44:19 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:56690 "EHLO
	mwinf0301.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261193AbTK2WoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 17:44:14 -0500
Date: Sat, 29 Nov 2003 23:44:11 +0100
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Sven Luther <sven.luther@wanadoo.fr>, John Bradford <john@grabjohn.com>,
       Szakacsits Szabolcs <szaka@sienet.hu>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031129224411.GA9214@iliana>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk> <20031129170103.GA6092@iliana> <20031129221424.GA5456@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031129221424.GA5456@win.tue.nl>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 11:14:24PM +0100, Andries Brouwer wrote:
> On Sat, Nov 29, 2003 at 06:01:03PM +0100, Sven Luther wrote:
> 
> > The only problem is that your BIOS will probably not be able
> > to boot from it
> 
> You seem to misunderstand the boot sequence.
> The BIOS does not generally do any parsing of partition tables.

A, ok. I am more familiar with open firmware, which does contain
partition table reading code.

That said, i really doubt that a standard BIOS can boot from a not MBR
containing disk, but i may be wrong.

Friendly,

Sven Luther
