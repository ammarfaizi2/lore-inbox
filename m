Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264456AbUEDSAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbUEDSAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 14:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUEDSAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 14:00:13 -0400
Received: from imap.gmx.net ([213.165.64.20]:28633 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264456AbUEDSAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 14:00:09 -0400
X-Authenticated: #20450766
Date: Tue, 4 May 2004 19:59:29 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: hda active and hdb sleep?
In-Reply-To: <20040503135145.GE1188@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.44.0405041958170.3598-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004, Pavel Machek wrote:

> > As soon as I issue hdparm -Y /dev/hdb I get errors on hda and it doesn't
> > seem to be possible to have hdb in sleep and hfa active. I think, those
> > power-states are purely per-device, aren't they. It's a VIA ProSavage
> > KM133 chipset. 2.6.3 kernel at the moment.
>
> Does -y work?

Yes!

Thanks
Guennadi
---
Guennadi Liakhovetski


