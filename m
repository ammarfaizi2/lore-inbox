Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUJXTtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUJXTtU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 15:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUJXTtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 15:49:20 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:18442 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261186AbUJXTtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 15:49:11 -0400
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] ide-2.6 update
From: James Cloos <cloos@jhcloos.com>
In-Reply-To: <58cb370e04102405081d62bf40@mail.gmail.com> (Bartlomiej
 Zolnierkiewicz's message of "Sun, 24 Oct 2004 14:08:15 +0200")
References: <58cb370e04102405081d62bf40@mail.gmail.com>
X-Hashcash: 0:041024:bzolnier@gmail.com:d40f67b840e9f8c5
X-Hashcash: 0:041024:linux-ide@vger.kernel.org:f9b34b9460aa9ec9
X-Hashcash: 0:041024:linux-kernel@vger.kernel.org:153b6e5dd3d450d1
Date: Sun, 24 Oct 2004 12:48:58 -0700
Message-ID: <m3zn2boq1h.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are all of the data displayed in /proc/ide/piix et al now available
in sysfs?  If so, 'twould've been useful for a small utility -- a
la lsscsi(8) -- that can format that data like the /proc/ide files
to have been released before dropping the /proc files....

It is a regression to loose convenient access to the controllers'
current configs....

-JimC
