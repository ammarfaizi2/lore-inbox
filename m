Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTDUQnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 12:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbTDUQnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 12:43:33 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:60874 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261707AbTDUQnc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 12:43:32 -0400
Date: Mon, 21 Apr 2003 12:55:35 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: 2.5.68-bk1 renames IDE disks, /dev/hda is directory
In-Reply-To: <20030421183935.A27811@lst.de>
Message-ID: <Pine.LNX.4.55.0304211254220.15244@marabou.research.att.com>
References: <Pine.LNX.4.55.0304211157430.14766@marabou.research.att.com>
 <20030421183935.A27811@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, Christoph Hellwig wrote:

> Hey, that wasn't intentation.  In fact it's a stupid brown-paperbag bug
> only hidden by mount-by-label :)

The patch worked nevertheless :)
Thank you!

-- 
Regards,
Pavel Roskin
