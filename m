Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTFQK3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 06:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTFQK3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 06:29:08 -0400
Received: from dsl7-003.express.oricom.ca ([64.18.175.3]:4624 "EHLO
	apac.cjb.net") by vger.kernel.org with ESMTP id S261688AbTFQK3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 06:29:07 -0400
Message-Id: <20030617103910.E7ABB1B59A@apac.cjb.net>
Date: Tue, 17 Jun 2003 06:39:10 -0400 (EDT)
From: root@apac.cjb.net (Charlie Root)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here is the bug I found: when umount network file system. I enabled nfs4 experimental in both client and server. On that machine it act as a client and the remote server use nfs3 (freebsd 4.8). I had to type the whole "oops" message by hand :S and I didnt had time to copy it completly (the screen goes blank). MAYBE it could help ..... 
Here is it -> http://perso.apac.cjb.net/bug.txt
Sorry for this bad bug report.
Wish it could help
Bye
Simon Veilleux,
phpquebec.org
