Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTDXQt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTDXQt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:49:26 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:53709 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261321AbTDXQtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:49:25 -0400
Date: Thu, 24 Apr 2003 13:01:32 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org, viro@www.linux.org.uk
Subject: Re: 2.5.68-bk1 renames IDE disks, /dev/hda is directory
In-Reply-To: <20030421183935.A27811@lst.de>
Message-ID: <Pine.LNX.4.55.0304241257520.2855@marabou.research.att.com>
References: <Pine.LNX.4.55.0304211157430.14766@marabou.research.att.com>
 <20030421183935.A27811@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, Christoph Hellwig wrote:

Somebody please apply this patch:

http://hypermail.idiosynkrasia.net/linux-kernel/latestweek/0150.html

It's still not in 2.5.68-bk5.  It's a major headache for everybody who
tries to use devfs with the current kernel.

-- 
Regards,
Pavel Roskin
