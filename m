Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVF2RYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVF2RYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVF2RWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:22:01 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:24338 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262633AbVF2ROc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:14:32 -0400
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix slab cache leak
References: <Pine.LNX.4.58.0506290906010.9107@sbz-30.cs.Helsinki.FI>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 30 Jun 2005 02:14:05 +0900
In-Reply-To: <Pine.LNX.4.58.0506290906010.9107@sbz-30.cs.Helsinki.FI> (Pekka J. Enberg's message of "Wed, 29 Jun 2005 09:06:53 +0300 (EEST)")
Message-ID: <871x6lm6g2.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> writes:

> This patch plugs a slab cache leak in fat module initialization.

Thanks. ACK.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
