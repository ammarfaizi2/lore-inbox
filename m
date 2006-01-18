Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWARXDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWARXDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWARXDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:03:36 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:4260 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030431AbWARXDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:03:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jeff Mahoney <jeffm@suse.com>
Subject: Re: 2.6.16-rc1 + reiser* from -rc1-mm1 : BUG with reiserfs
Date: Thu, 19 Jan 2006 00:04:35 +0100
User-Agent: KMail/1.9
Cc: Damien Wyart <damien.wyart@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060118122631.GA12363@localhost.localdomain> <43CEC61E.2040500@suse.com>
In-Reply-To: <43CEC61E.2040500@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601190004.36549.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 18 January 2006 23:50, Jeff Mahoney wrote:
}-- snip --{
> 
> Sigh. Ok. Back out the reiserfs patches

Those:

reiserfs-fix-is_reusable-bitmap-check-to-not-traverse-the-bitmap-info-array.patch
reiserfs-clean-up-bitmap-block-buffer-head-references.patch
reiserfs-move-bitmap-loading-to-bitmapc.patch
reiserfs-on-demand-bitmap-loading.patch
reiserfs-on-demand-bitmap-loading-fix.patch
reiserfs-on-demand-bitmap-loading-warning-fix.patch

or just all of the reiserfs patches?

Rafael
