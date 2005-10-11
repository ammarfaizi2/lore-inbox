Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVJKUDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVJKUDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVJKUDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:03:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52396 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932357AbVJKUDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:03:22 -0400
Date: Tue, 11 Oct 2005 16:02:33 -0400
From: Alan Cox <alan@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>, vsu@altlinux.ru,
       linux-usb-devel@lists.sourceforge.net, laforge@gnumonks.org,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       security@linux.kernel.org, vendor-sec@lst.de
Subject: Re: [Security] Re: [linux-usb-devel] Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20051011200233.GB25581@devserv.devel.redhat.com>
References: <Pine.LNX.4.61.0510111352400.6379@chaos.analogic.com> <Pine.LNX.4.44L0.0510111505540.3821-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0510111505540.3821-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 03:13:39PM -0400, Alan Stern wrote:
> Surely Linux uses entirely original code, with no hangovers from the
> original AT&T Unix...  Besides, to the best of my recollection, the two
> operations are equal in speed on a PDP-11.

I've no idea but I don't believe the relative speed of PDP_11 operations is
security critical in Linux so can you trim the cc line

