Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTDIJSZ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbTDIJSZ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:18:25 -0400
Received: from mail.mediaways.net ([193.189.224.113]:38612 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262951AbTDIJSY (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:18:24 -0400
Subject: mounting partitions on loopback fs ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049880018.2764.46.camel@fortknox>
Mime-Version: 1.0
Date: 09 Apr 2003 11:20:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I dd'ed a whole harddisk into a file and set it up using losetup...

when I fdisk /dev/loop0 I can clearly see all the partitions. However I
have no idea how I could mount them. Is that possible / what needs to be
tweaked to make that possible ?

Regards,
Soeren.

