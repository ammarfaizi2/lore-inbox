Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTLMCaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 21:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTLMCaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 21:30:52 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:55748 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263378AbTLMCau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 21:30:50 -0500
Date: Fri, 12 Dec 2003 18:30:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ananda Bhattacharya <anandab@cabm.rutgers.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.0-test11 VFS problem
Message-ID: <20031213023045.GO15401@matchmail.com>
Mail-Followup-To: Ananda Bhattacharya <anandab@cabm.rutgers.edu>,
	linux-kernel@vger.kernel.org
References: <brdq5f$9sd$1@cesium.transmeta.com> <Pine.LNX.4.44.0312122059410.4174-100000@puma.cabm.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312122059410.4174-100000@puma.cabm.rutgers.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 09:06:43PM -0500, Ananda Bhattacharya wrote:
> ###################################
> VFS Cannot open root device "hda5" 
> Please append a correct "root=" boot option 
> Kernel Panic: VFS: Unable to mount root filesystem on hda5 
> ###################################

What filesystem is on hda5? and did you specify it as /dev/hda5? and did you  
compile that filesystem into your kernel (ie, not as a module)?











