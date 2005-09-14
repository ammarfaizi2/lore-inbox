Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVINUAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVINUAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVINUAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:00:36 -0400
Received: from nome.ca ([65.61.200.81]:178 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S932490AbVINUAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:00:35 -0400
Date: Wed, 14 Sep 2005 13:01:24 -0700
From: Mike Bell <mike@mikebell.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050914200123.GC15017@mikebell.org>
Mail-Followup-To: Mike Bell <mike@mikebell.org>,
	Kyle Moffett <mrmacman_g4@mac.com>, linux@horizon.com,
	linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
References: <20050911114435.5990.qmail@science.horizon.com> <808CC4DC-15F3-4F6E-A9C6-6CBEC3D5415F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <808CC4DC-15F3-4F6E-A9C6-6CBEC3D5415F@mac.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 11:43:02AM -0400, Kyle Moffett wrote:
> That sounds like _exactly_ the case where the Debian folks could
> maintain the out-of-tree ndevfs patch for a while until they got their
> installer floppies and such migrated to udev.

Then you know nothing about the subject at hand. Moving from devfs to
ndevfs is dramatically /harder/ than moving from devfs to udev. ndevfs
is not devfs compatible in any way, shape or form.
