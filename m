Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbWJBGdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWJBGdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWJBGdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:33:00 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:61347 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S932649AbWJBGc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:32:59 -0400
Date: Mon, 2 Oct 2006 08:32:39 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rossb@google.com, sam@ravnborg.org
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to -mm tree
Message-ID: <20061002063239.GA12872@aepfle.de>
References: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net> <20060915154752.d7bdb8a0.rdunlap@xenotime.net> <20060915164135.34adb303.akpm@osdl.org> <20061001181702.f0fce3ac.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061001181702.f0fce3ac.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, Randy Dunlap wrote:

> Can any of the distro people chime in here?  Andrew merged this
> patch to mainline today.  Several people had disagreed with merging
> it, but now Andrew says we need more discussion (if or) in order to
> revert it.

Everyone who wants this to be =m can do so.
The rest will likely leave it =y.
