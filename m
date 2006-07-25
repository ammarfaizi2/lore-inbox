Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWGYXrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWGYXrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWGYXrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:47:18 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:4752
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S964856AbWGYXrR (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:47:17 -0400
Date: Wed, 26 Jul 2006 01:48:18 +0200
From: andrea@cpushare.com
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Hans Reiser <reiser@namesys.com>, Nikita Danilov <nikita@clusterfs.com>,
       Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060725234818.GD32243@opteron.random>
References: <44C65931.6030207@namesys.com> <200607252117.k6PLHmSp016039@laptop13.inf.utfsm.cl> <20060725224833.GG18867@voodoo.jdc.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725224833.GG18867@voodoo.jdc.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 06:48:35PM -0400, Jim Crilly wrote:
> Well if you take a look at the KLive webpage you'll see that there's only
> 485 computers providing data. I'm not trying to knock Andrea's project, but
> the sample size is quite small and only really representative of people who
> would be inclined to read lkml, patch their kernels, etc.

There are quite a few using the official distro kernels but the point
remains that the KLive users are probably the ones most interested to
try all new stuff and to live on the edge. They're not afraid to put
the new technologies to work for them. That's probably why they're
using reiser4 so much. OTOH they're probably the ones putting the fs
under the most stress, a regular desktop user not capable of running
klive.sh --install from the shell, would probably leave his CPU and
harddisk idle most of the time too.

Being this only a sample I can't come up with absolute figures, but
obviously there are more users than what is being recorded by KLive.

However the sample is not so small, in less then a year KLive logged
76740 days of uptime and 61355 reboots (or klive session restarts),
and like you noticed an average of about 400-500 systems are always
connected.
