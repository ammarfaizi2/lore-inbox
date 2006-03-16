Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752016AbWCPPlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbWCPPlN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWCPPlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:41:12 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:12744 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1752016AbWCPPlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:41:12 -0500
Date: Thu, 16 Mar 2006 10:41:08 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Ballentine, Casey" <crballentine@essvote.com>
cc: "'Mauro Carvalho Chehab'" <mchehab@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, <video4linux-list@redhat.com>,
       <linux-usb-devel@lists.sourceforge.net>,
       <usb-storage@lists.one-eyed-alien.net>,
       <v4l-dvb-maintainer@linuxtv.org>, <mdharm-usb@one-eyed-alien.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] RE: [usb-storage] Re: [v4l-dvb-maintainer]
 2.6.16-rc: saa7134 + u sb-storage = freeze
In-Reply-To: <820212CF2FD63647B52A8F64B35352B20B942298@essomaexc1.essvote.com>
Message-ID: <Pine.LNX.4.44L0.0603161039410.5253-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2006, Ballentine, Casey wrote:

> Mauro,
> 
> I would bet we could add the vt8235 to the list of broken chipsets 
> as well, if it's not already there.  My company has completely 
> disabled DMA in the 2.6.13.4 kernel we're running on an 
> EPIA PD-10000 board due to lockupslike these.  We came across 
> a thread on the via arena website while researching possible 
> problems on the VIA boards:
> 
> http://forums.viaarena.com/messageview.aspx?catid=28&threadid=60131&STARTPAG
> E=1&FTVAR_FORUMVIEWTMP=Linear

Here's another interesting link from VIA's site.  They claim to have fixed 
the DMA problem (for some boards, anyway):

http://forums.viaarena.com/messageview.aspx?catid=28&threadid=67386&enterthread=y

Alan Stern

