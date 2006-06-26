Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933007AbWFZUGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933007AbWFZUGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933003AbWFZUGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:06:46 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:26298 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S933007AbWFZUGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:06:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [Suspend2][ 0/7] Proc file support
Date: Mon, 26 Jun 2006 22:07:37 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606262207.38006.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 18:47, Nigel Cunningham wrote:
> 
> Generic routines for implementing the /proc/suspend2 files that allow
> the user to configure and tune the subsystem according to their needs.

All of the following patches seem to modify the same file: kernel/power/proc.c
I'd prefer if these changes were all done in one patch.

Rafael
