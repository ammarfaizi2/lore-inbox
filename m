Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267822AbUHPRwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267822AbUHPRwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUHPRwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:52:43 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:23188 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S267822AbUHPRwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:52:40 -0400
From: Hubert Tonneau <hubert.tonneau@heliogroup.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: USB storage crash report in 2.6
Date: Mon, 16 Aug 2004 17:35:20 GMT
Message-ID: <04BRKUX12@server5.heliogroup.fr>
X-Mailer: Pliant 92
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau wrote:
>
> When I try to copy large amount of datas (more than 100 GB) between USB
> attached disks, I get a crash with Linux 2.6

The crash will not happen if I use an UP instead of SMP kernel.

PS: there is no problem with the disks since I get the exact same behaviour with
    a set of three new ones

