Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTLKNOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbTLKNOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:14:06 -0500
Received: from nefty.hu ([195.70.37.175]:64394 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S264933AbTLKNOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:14:04 -0500
Date: Thu, 11 Dec 2003 14:14:16 +0100 (CET)
From: Zoltan NAGY <nagyz@nefty.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crypto + dm = crash
Message-ID: <Pine.LNX.4.58.0312111413080.22509@nefty.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ohm, sorry, there was a typo in my last mail :)
so, the sequence is:
mkraid /dev/md0
losetup -e aes /dev/loop0 /dev/md0
mkraid /dev/loop0

sorry for my first misleading mail..

Regards,

--
Zoltan NAGY,
Network Administrator

