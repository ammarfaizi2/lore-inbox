Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVBTWOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVBTWOH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 17:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVBTWOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 17:14:07 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:60555 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S262024AbVBTWN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 17:13:59 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: proc path_walk glitch ?
To: Der Herr Hofrat <der.herr@hofr.at>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 20 Feb 2005 23:14:13 +0100
References: <fa.f4pcrfo.f22jh6@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1D2zLB-0001D1-Vf@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Der Herr Hofrat <der.herr@hofr.at> wrote:

> cd /proc/8655
> kill -9 8655
> ls
> /usr/bin/ls: .: Stale NFS file handle

Seems to be fixed in 2.6.10-ac9 or earlier
