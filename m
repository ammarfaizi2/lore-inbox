Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbVHPSOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVHPSOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVHPSOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:14:43 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:1683 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030278AbVHPSOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:14:42 -0400
Date: Tue, 16 Aug 2005 14:09:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Cc: "lkml.hyoshiok@gmail.com" <lkml.hyoshiok@gmail.com>,
       "taka@valinux.co.jp" <taka@valinux.co.jp>,
       Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200508161412_MC3-1-A759-465F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005 at 19:16:17 +0900 (JST), Hiro Yoshioka wrote:

> oh, really? Does the linux kernel take care of
> SSE save/restore on a task switch?

 Check out XMMS_SAVE and XMMS_RESTORE in include/asm-i386/xor.h


__
Chuck
