Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTKCTjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 14:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTKCTjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 14:39:44 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:34790 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262705AbTKCTjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 14:39:43 -0500
Date: Mon, 3 Nov 2003 20:39:40 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: how to restart userland?
Message-ID: <20031103193940.GA16820@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would anyone know of a proven way to completely restart the userland
of a Linux system?

i.e. something like
# echo whatever-restart >/proc/wherever

Killing all processes.
Killing init.
Unmounting all filesystems.
VFS: Mounted root (ext2 filesystem).
INIT: v2.84 booting
...

Thanks for any pointers,
-- 
Tomas Szepe <szepe@pinerecords.com>
