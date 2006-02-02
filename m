Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWBBPnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWBBPnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWBBPnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:43:32 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:51980 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932084AbWBBPnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:43:31 -0500
Date: Thu, 2 Feb 2006 16:43:19 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060202154319.GA96923@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Nigel Cunningham <nigel@suspend2.net>,
	Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com> <200602022228.20032.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602022228.20032.nigel@suspend2.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 10:28:15PM +1000, Nigel Cunningham wrote:
> Shouldn't the question be "Why are we making this more complicated by moving 
> it to userspace?"

Indeed.  It seems that turning the kernel into Hurd is the latest fad.

One question I'm wondering about though is that 99% of the "suspend
doesn't work reliably" messages were answered by "it's a driver's
fault".  I'm rather curious on how moving things to userspace is going
to fix that.

  OG.

