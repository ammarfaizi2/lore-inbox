Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266436AbUHIJ4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbUHIJ4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 05:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266443AbUHIJ4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 05:56:55 -0400
Received: from slider.rack66.net ([212.3.252.135]:45543 "EHLO
	slider.rack66.net") by vger.kernel.org with ESMTP id S266436AbUHIJ4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 05:56:52 -0400
Date: Mon, 9 Aug 2004 11:56:52 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Problem] 2.6.8-rc3: usb-storage devices are read-only (NOT related to iocharset)
Message-ID: <20040809095652.GB12667@debian>
Mail-Followup-To: "R. J. Wysocki" <rjwysocki@sisk.pl>,
	linux-kernel@vger.kernel.org
References: <200408082157.35469.rjwysocki@sisk.pl> <200408082208.02328.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408082208.02328.rjwysocki@sisk.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 10:09:23PM +0200, R. J. Wysocki wrote:
> On Sunday 08 of August 2004 21:57, R. J. Wysocki wrote:
> >
> > On 2.6.8-rc3 and 2.6.8-rc2-mm2 I get:
> >
> > chimera:~ # mount  -t vfat -o iocharset=iso8859-2 /dev/sdd1 /media/pendrive
> > [snip]
> > chimera:~ # mount  -t vfat -o codepage=437 /dev/sdd1 /media/pendrive
> > [snip]

Does it work if you specify both iocharset and codepage?


Regards,

Filip

-- 
A: Because it breaks the flow of normal conversation.
Q: Why don't we put the response before the request?
