Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTK2WOg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 17:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTK2WOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 17:14:36 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:31240 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261605AbTK2WOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 17:14:35 -0500
Date: Sat, 29 Nov 2003 23:14:24 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: John Bradford <john@grabjohn.com>, Szakacsits Szabolcs <szaka@sienet.hu>,
       Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031129221424.GA5456@win.tue.nl>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk> <20031129170103.GA6092@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031129170103.GA6092@iliana>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 06:01:03PM +0100, Sven Luther wrote:

> The only problem is that your BIOS will probably not be able
> to boot from it

You seem to misunderstand the boot sequence.
The BIOS does not generally do any parsing of partition tables.


