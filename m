Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTGKTqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbTGKToD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:44:03 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:21515
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265141AbTGKTmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:42:54 -0400
Date: Fri, 11 Jul 2003 12:57:37 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, xose@wanadoo.es
Subject: Re: is lvm stuck in 2.4 ?
Message-ID: <20030711195737.GC976@matchmail.com>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	xose@wanadoo.es
References: <3F0F0746.8060403@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0F0746.8060403@wanadoo.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 08:51:50PM +0200, Xose Vazquez Perez wrote:
> 
> kernel has version 1.0.5+ (22/07/2002), but latest
> is 1.0.7(2003/03/03). Is there any problem with 1.0.7 and
> 2.4 ?

Most likely not.  It probably hasn't been merged yet.

As well as the vfs patch needed for the journaled filesystems (forgot the
name).

Are there any efforts to get this merged?
