Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWDGIPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWDGIPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 04:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWDGIPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 04:15:49 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:31365 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932365AbWDGIPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 04:15:48 -0400
Date: Fri, 7 Apr 2006 10:15:46 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] [BUG ALSA 2.6.17-rc1] Oops when Gaim tries to play sound
Message-ID: <20060407081546.GC3947@harddisk-recovery.com>
References: <20060406132042.GF20402@harddisk-recovery.nl> <1144338706.2866.62.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144338706.2866.62.camel@mindpipe>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 11:51:45AM -0400, Lee Revell wrote:
> On Thu, 2006-04-06 at 15:20 +0200, Erik Mouw wrote:
> > Could be a locking error or an ALSA error, so message posted to lkml
> > and alsa-devel lists. Feel free to ask for more information.
> 
> Already reported (several times) to both LKML and alsa-devel.
> 
> See kernel bugzilla #6329

Rene Herman pointed it out in private. I applied
http://bugzilla.kernel.org/attachment.cgi?id=7779&action=view and
everything seems to work again.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
