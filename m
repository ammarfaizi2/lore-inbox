Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVCFPxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVCFPxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 10:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVCFPxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 10:53:55 -0500
Received: from xantronkunden2.de ([81.209.165.33]:12330 "EHLO
	kunden.xantronkunden2.de") by vger.kernel.org with ESMTP
	id S261420AbVCFPxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 10:53:54 -0500
Date: Sun, 6 Mar 2005 16:53:29 +0100
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/29] FAT: Updated FAT attributes patch
Message-ID: <20050306155329.GA1436@t-online.de>
References: <87ll92rl6a.fsf@devron.myhome.or.jp> <87hdjqrl44.fsf@devron.myhome.or.jp> <87d5uerl2j.fsf_-_@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5uerl2j.fsf_-_@devron.myhome.or.jp>
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 03:42:28AM +0900, OGAWA Hirofumi wrote:
> +/* <linux/videotext.h> has used 0x72 ('r') in collision, so skip a few */

These ioctls in videotext.h have been removed with 2.6.11. They were not used anywhere in the 
kernel.

Michael
