Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272455AbTHNQFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272468AbTHNQFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:05:47 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:64690 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S272455AbTHNQFl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:05:41 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 14 Aug 2003 18:06:31 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Dennis =?iso-8859-1?Q?Bj=F6rklund?= <db@zigo.dhs.org>
Cc: Flameeyes <dgp85@users.sourceforge.net>, Pavel Machek <pavel@suse.cz>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030814160630.GA14967@bytesex.org>
References: <20030811163913.GA16568@bytesex.org> <Pine.LNX.4.44.0308141719460.2191-100000@zigo.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0308141719460.2191-100000@zigo.dhs.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 05:22:27PM +0200, Dennis Björklund wrote:
> On Mon, 11 Aug 2003, Gerd Knorr wrote:
> 
> Would this allow you to have one reciever and different remote controles
> (used for different programs in the end)?

If the two remote controls send different codes it should be possible to
map them to different "keys" and disturgish them that way.

  Gerd

-- 
sigfault
