Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUJWJ62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUJWJ62 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 05:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUJWJ62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 05:58:28 -0400
Received: from i31207.upc-i.chello.nl ([62.195.31.207]:58245 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S266189AbUJWJ50
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 05:57:26 -0400
Subject: Re: Unknown symbol kill_proc_info in 2.6.10-rc1
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: syphir@syphir.sytes.net
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <417A2292.9090008@syphir.sytes.net>
References: <417A2292.9090008@syphir.sytes.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098525430.2819.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 23 Oct 2004 11:57:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 11:21, C.Y.M wrote:
> After building 2.6.10-rc1, i was unable to load my "lufs" module due to 
> an unknown symbol error (kill_proc_info).  When I examined the 

the big question is why lufs uses kill_proc_info in the first place... 

