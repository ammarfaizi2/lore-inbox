Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbULILDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbULILDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 06:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbULILDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 06:03:01 -0500
Received: from mx1.informatik.uni-stuttgart.de ([129.69.211.41]:42683 "EHLO
	mx1.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S261499AbULILCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 06:02:48 -0500
Date: Thu, 9 Dec 2004 12:02:47 +0100
From: lkml@Think-Future.de
To: Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: Re: Promise module (old) broken
Message-ID: <20041209120247.A16313@marvin.informatik.uni-stuttgart.de>
Reply-To: lkml@Think-Future.de
Mail-Followup-To: lkml@Think-Future.de,
	Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://www.Think-Future.de
X-Editor: Vi it! http://www.vim.org
X-Bkp: p2mi
X-GnuPG-Key: gpg --keyserver search.keyserver.net --recv-keys 06232116
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi,

> Haven't you forgot to compile in pdc202xx_old driver?
CONFIG_BLK_DEV_PDC202XX_OLD=y

> and give us at least dmesgs and configs.
This is the same machine and config as in the thread "".


        Nils

PS: I am not subscribed to this list.

