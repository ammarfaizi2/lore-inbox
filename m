Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbUBBLmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 06:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUBBLmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 06:42:49 -0500
Received: from thor.65535.net ([216.17.104.19]:42504 "EHLO thor.65535.net")
	by vger.kernel.org with ESMTP id S265346AbUBBLms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 06:42:48 -0500
Date: Mon, 2 Feb 2004 11:44:44 +0000 (GMT)
From: Rus Foster <rghf@fsck.me.uk>
X-X-Sender: rghf@bitch.localdomain
To: linux-kernel@vger.kernel.org
Subject: Horrible NFS performace on 2.6.1 -> 2.6.2-bk1
Message-ID: <Pine.LNX.4.58.0402021141360.2684@bitch.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
 I asked this on the debian-user list but was told to ask here. Now I've
looked through the archieves and can find a few threads similar but no
definite answers. My current config is as follows

NFS Server Debian Woody Stable + 2.6.2-bk1
NFS Client Debian Woody Stable + 2.6.1

If I mount the server as udp I get 0 response from the server and if I
mount as tcp I get about 8kb/s from the server. I've tried tweaking
rsizw/wsize and have got nothing. Can anyone suggest a fix + more info I
can provide? (tcpdump?)

Thanks

Rus

-- 
e: support@vpscolo.com
t: 1-888-327-6330
www.jvds.com - Root on your own box
www.vpscolo.com - Your next hosting company
