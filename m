Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTFXWUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTFXWUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:20:21 -0400
Received: from relay02.roc.ny.frontiernet.net ([66.133.131.35]:61652 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S262955AbTFXWUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:20:18 -0400
Date: Tue, 24 Jun 2003 18:34:27 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi on 2.4.21 (on IBM Thinkpad T30)
Message-ID: <20030624183427.H30001@newbox.localdomain>
References: <3EF753EC.9080807@homemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EF753EC.9080807@homemail.com>; from dsen@homemail.com on Tue, Jun 24, 2003 at 05:24:28AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Sen on Tue 24/06 05:24 +1000:
> Kernel 2.4.21 causes hangs and/or ooops during boot up if
> I have a "probeall scsi_hostadapter ide-scsi" in my
> /etc/modules.conf. If I take out that line and manually
> load the module after the laptop has booted, everything is
> fine.

I probably have the same CD-RW that you do (in the T30) and
I just use hdc=ide-scsi on kernel command line, no need for
manually loading.  Works fine but don't try burning with
magicdev running :)
