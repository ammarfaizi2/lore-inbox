Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTL2RbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTL2RbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:31:24 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:25472 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S263823AbTL2RbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:31:19 -0500
Date: Mon, 29 Dec 2003 18:31:18 +0100
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't mount USB partition as root
Message-ID: <20031229183118.A32137@beton.cybernet.src>
References: <20031229173853.A32038@beton.cybernet.src> <20031229164539.GD30794@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031229164539.GD30794@louise.pinerecords.com>; from szepe@pinerecords.com on Mon, Dec 29, 2003 at 05:45:39PM +0100
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 05:45:39PM +0100, Tomas Szepe wrote:
> On Dec-29 2003, Mon, 17:38 +0100
> Karel Kulhavý <clock@twibright.com> wrote:
> 
> > Is it possible to boot kernel with root from /dev/sda1 (USB)?
> > partition table: whole /dev/sda is one partition (sda1), type 83 (Linux).
> > Tried also switching on and off hotplugging in kernel and it didn't help.
> 
> Well, is the device detected and the partition table scanned before the
> root mount is attempted?

The messages jump around fast and there is no possibility to scroll
back once the kernel stops, but I am convinced that nothing is said about
detecting the device.

However, if booting the kernel "normally", the device gets detected (later).

How do I use the console? Is it something like nullmodem cable console in
Windows NT?  I have given away my nullmodem cable to a friend for purpose of
debugging NT kernel so what possibilities remain?

Cl<
