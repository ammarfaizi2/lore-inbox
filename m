Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVCJBzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVCJBzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVCJBRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:17:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:52895 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262623AbVCJAm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:29 -0500
Date: Wed, 9 Mar 2005 16:24:44 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] debugfs fixes for 2.6.11
Message-ID: <20050310002444.GA32153@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are two debugfs fixes.  They have been in the -mm releases for a
while.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/2.6.11/debugfs

Individual patches will follow, sent to the linux-kernel list.

thanks,

greg k-h

 fs/debugfs/file.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
-----


Greg Kroah-Hartman:
  o debugfs: fix bool built-in type
  o debufs: make built in types add a \n to their output

