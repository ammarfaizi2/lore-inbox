Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVD1RA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVD1RA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVD1RAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:00:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45254 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262170AbVD1RAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:00:21 -0400
Date: Thu, 28 Apr 2005 12:59:15 -0400
From: Dave Jones <davej@redhat.com>
To: Mark Rosenstand <mark@ossholes.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Extremely poor umass transfer rates
Message-ID: <20050428165915.GG30768@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Mark Rosenstand <mark@ossholes.org>, linux-kernel@vger.kernel.org
References: <1114704142.8410.4.camel@mjollnir.bootless.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114704142.8410.4.camel@mjollnir.bootless.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 06:02:22PM +0200, Mark Rosenstand wrote:
 > I get transfer rates at around 30 kB/s to USB mass storage devices. It
 > applies to both my keyring and my mp3 player. Both are running vfat.
 > 
 > I'm running 2.6.12-rc3 for amd64 with patches for inotify and skge. The
 > motherboard is an ASUS K8V-X (VIA K8T800).
 > 
 > It worked alright earlier (2.6.10 or 2.6.11, I'll test later if
 > necessary.)
 > 
 > Also, if I transfer more than one file at a time the music tracks start
 > overlapping on my mp3 player.

Are you running it on a USB 2.0 capable interface ?
Is your mp3 player USB2.0 capable ?
USB1.1 is painfully slow for storage.

		Dave

