Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVB1C4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVB1C4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 21:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVB1C4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 21:56:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44193 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261514AbVB1C4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 21:56:14 -0500
Date: Sun, 27 Feb 2005 21:56:09 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Shawn Starr <shawn.starr@rogers.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: SELinux and sysfs
In-Reply-To: <200502270021.24252.shawn.starr@rogers.com>
Message-ID: <Xine.LNX.4.44.0502272151440.21072-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2005, Shawn Starr wrote:

> Perhaps in future, maybe SELinux could take advantage of sysfs to modify some 
> policies? Is this doable?
> Sure, we still need some flat files for static configurations, but what about 
> dynamic ones?

This is already possible via the 'booleans' directory under the selinuxfs
root.

See http://www.tresys.com/Downloads/selinux-tools/README-COND.txt


- James
-- 
James Morris
<jmorris@redhat.com>


