Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTLVLkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 06:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbTLVLkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 06:40:09 -0500
Received: from intra.cyclades.com ([64.186.161.6]:14774 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264533AbTLVLkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 06:40:05 -0500
Date: Mon, 22 Dec 2003 09:27:01 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Octave <oles@ovh.net>
Cc: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org,
       andrea@suse.de
Subject: Re: lot of VM problem with 2.4.23
In-Reply-To: <20031221234350.GD4897@ovh.net>
Message-ID: <Pine.LNX.4.58L.0312220921120.2691@logos.cnet>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local>
 <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221184709.GO25043@ovh.net>
 <20031221185959.GE1494@louise.pinerecords.com> <20031221234350.GD4897@ovh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Dec 2003, Octave wrote:

> On Sun, Dec 21, 2003 at 07:59:59PM +0100, Tomas Szepe wrote:
> > On Dec-21 2003, Sun, 19:47 +0100
> > Octave <oles@ovh.net> wrote:
> >
> > > You can run this easy script. 2.4.19 takes about 30 minutes
> > > to kill all process. 2.4.23 takes about 60 minutes.
> >
> > Can you also try 2.4.24-pre1 with the OOM killer enabled?
>
> I complied 2.4.24-pre1 with OOM killer. After 2 minutes of
> test, server is down.

Hi Octave,

What do you mean with "server is down" ? The OOM killer killed an
application ? What were the messages?

Under out of memory, 2.4.22 should also kill a process, but you say it
doesnt.

