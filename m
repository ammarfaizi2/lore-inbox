Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945934AbWBCT5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945934AbWBCT5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbWBCT5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:57:25 -0500
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:7558 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1945934AbWBCT5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:57:24 -0500
Date: Fri, 3 Feb 2006 20:57:16 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-c2
Message-ID: <20060203205716.7ed38386@localhost>
In-Reply-To: <43E3A001.7080309@lwfinger.net>
References: <43E39932.4000001@lwfinger.net>
	<Pine.LNX.4.64.0602031007420.4630@g5.osdl.org>
	<43E3A001.7080309@lwfinger.net>
X-Mailer: Sylpheed-Claws 2.0.0-rc4 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2006 12:25:05 -0600
Larry Finger <Larry.Finger@lwfinger.net> wrote:

> Thanks for the explanation. I have to admit that git is pretty much a black box to me. I use the 
> guide at http://linux.yyz.us/git-howto.html and it recommends using rsync. I'll have to figure out 
> how to change to git protocol.

Just do:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

:)

-- 
	Paolo Ornati
	Linux 2.6.15-kolivasPatch on x86_64
