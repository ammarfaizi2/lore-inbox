Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbTH0HKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbTH0HKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:10:23 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:45695 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263195AbTH0HKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:10:18 -0400
Date: Wed, 27 Aug 2003 00:10:15 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Voluspa <lista1@comhem.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS regression since 2.6.0-test3 (in -test4 and 4-mm1)
Message-ID: <20030827001015.A2686@google.com>
References: <20030827052517.79d65038.lista1@comhem.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030827052517.79d65038.lista1@comhem.se>; from lista1@comhem.se on Wed, Aug 27, 2003 at 05:25:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 05:25:17AM +0200, Voluspa wrote:
> Aug 27 03:59:59 loke kernel: eth0: media is TP.
> Aug 27 04:02:34 loke kernel: nfs warning: mount version older than
> kernel
> 
> Duh! I'm using your util-linux-2.12pre.tar.gz so stop complaining.

BTW, I've submitted the util-linux patches needed for the mount update a
while back, I have no idea if they ever made it.  (My mail got put into
the "waiting for moderator approval" queue.)

/fc
