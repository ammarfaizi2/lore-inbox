Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266268AbUAGSM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUAGSM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:12:28 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:59271 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S266268AbUAGSMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:12:25 -0500
Message-ID: <3FFC4BF1.B6A5ADAE@users.sourceforge.net>
Date: Wed, 07 Jan 2004 20:12:01 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ruben Garcia <ruben@ugr.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loop device changes the block size and causes misaligned accessesto 
 the real device, which can't be processed
References: <3FFC3BF4.6080105@ugr.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruben Garcia wrote:
> The loop device advertises a block size of 1024 even when configured
> over a cdrom.

This bug and many other loop bugs are fixed in loop-AES package.

http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.0d.tar.bz2

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
