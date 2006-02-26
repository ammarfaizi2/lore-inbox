Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWBZNdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWBZNdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWBZNdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:33:15 -0500
Received: from CPE-24-31-249-53.kc.res.rr.com ([24.31.249.53]:19845 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1751118AbWBZNdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:33:14 -0500
From: Luke-Jr <luke@dashjr.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works ;)
Date: Sun, 26 Feb 2006 13:39:12 +0000
User-Agent: KMail/1.9.1
Cc: "Bernhard Rosenkraenzer" <bero@arklinux.org>, linux-kernel@vger.kernel.org
References: <200602250042.51677.bero@arklinux.org> <200602261330.15709.luke@dashjr.org> <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com>
In-Reply-To: <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602261339.13821.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 February 2006 13:29, Jesper Juhl wrote:
> On 2/26/06, Luke-Jr <luke@dashjr.org> wrote:
> > On Friday 24 February 2006 23:42, Bernhard Rosenkraenzer wrote:
> > > I've just released dvdrtools 0.3.1
> > > (http://www.arklinux.org/projects/dvdrtools/). It is a fork of cdrtools
> > > that (as the name indicates) adds support for writing to DVD-R and
> > > DVD-RW disks using purely Free Software,
> >
> > also DVD+R/RW/DL, I hope?
>
> And what about DVD-RAM drives? Any plans to support those?

My [limited] understanding of DVD-RAM drives was that they are basically 
removable block devices... you wouldn't need a recording program for that, 
you'd use it like a floppy.
