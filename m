Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270649AbUJUKie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270649AbUJUKie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268368AbUJUJvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:51:55 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:60467 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269065AbUJUJqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:46:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=omAXegKA2/dhi2WzNCnQRpbZf4YoqODHOM+DaAF4xeoE0/Z4VxzWboB4SC5JcU4oMWplF2vKtIMIXt2zDdiGWWN3C62VDp2gbZtdsK6TJoG6Iy7m9Nl+L6JGGSD/Sk7EqpERd2B0SkdIU+acEl44yefwyFc4Urco0IGe08ha2CU=
Message-ID: <e7b30b2404102102466dc71118@mail.gmail.com>
Date: Thu, 21 Oct 2004 17:46:29 +0800
From: Mildred Frisco <mildred.frisco@gmail.com>
Reply-To: Mildred Frisco <mildred.frisco@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: making a linux kernel with no root filesystem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I would like to ask help in compiling a minimal linux kernel. 
Basically, it would only contain the kernel andno filesystem (or
probably devfs).  I would only have to boot the kernel from floppy.
Then after the necessary kernel initializations, I would issue a
prompt where I can either shutdown or reboot the system. That's the
only functionality required.  As I've learned from the init program
(and startup scripts), the init services and shutdown commands are
called from /sbin. However, I do not require to mount the root fs
anymore.  I also tried to search for the source code of the shutdown
program but I can't find it.  Please help on the steps that I should
do.
Thanks in advance.
Please CC my email add in the reply. Thanks

Mildred <mildred.frisco@gmail.com>
