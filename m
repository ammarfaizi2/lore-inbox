Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932780AbWJGTTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbWJGTTk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWJGTTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:19:40 -0400
Received: from eazy.amigager.de ([213.239.192.238]:54160 "EHLO
	eazy.amigager.de") by vger.kernel.org with ESMTP id S932780AbWJGTTj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:19:39 -0400
Date: Sat, 7 Oct 2006 21:19:38 +0200
From: Tino Keitel <tino.keitel@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [resend] [git pull] drm tree for 2.6.19-rc1
Message-ID: <20061007191938.GA18426@dose.home.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0609300336000.4402@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609300336000.4402@skynet.skynet.ie>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 03:37:16 +0100, Dave Airlie wrote:
> 
> Hi Linus,
> 
> This is the DRM tree, the main work is the addition of simpler clean memory
> manager which fixes a lot of problems for Via and Sis users and the Intel
> 965 support.
> 
> Please pull from 'drm-patches' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git 
> drm-patches

How about the vblank patch for the broken video timing in 2.6.18? It is
commit 881ba569929ceafd42e3c86228b0172099083d1d in
git://anongit.freedesktop.org/git/mesa/drm and solved the problem for
me.

Regards,
Tino
