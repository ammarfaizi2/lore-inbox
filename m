Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272942AbTHPXl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 19:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273252AbTHPXlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 19:41:55 -0400
Received: from air.nwconx.net ([216.211.26.26]:51938 "EHLO air.on.ca")
	by vger.kernel.org with ESMTP id S272942AbTHPXly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 19:41:54 -0400
From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
To: linux-kernel@vger.kernel.org
Subject: Initramfs confusion
Date: Sat, 16 Aug 2003 19:40:52 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308161940.52579.gkajmowi@tbaytel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am just begining to test out 2.6 with an eye on use by X-terminals without 
hard drives or NFS. As such I am quite enthusiastic about initramfs.  After 
much stumbling around I created a root image that I would like to test, 
compiled into kernel and created image.

I am doing testing under VMWare with 2.88 MB floppy images (for testing 
purposes), but lilo is barfing trying to write to a regular file as a raw 
device (doesn't know how to handle device 0x0700).

I cannot use a real floppy because I do not have any 2.88 MB floppies

Any suggestions?  

Thanks for the help.

Garrett Kajmowicz
gkajmowi@tbaytel.net

