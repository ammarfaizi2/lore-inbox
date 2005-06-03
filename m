Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVFCXoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVFCXoY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVFCXoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:44:23 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:54913 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261182AbVFCXoS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:44:18 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5 : repeatable modprobe usb-storage hang
Date: Fri, 3 Jun 2005 19:44:19 -0400
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200506031341.17749.kernel-stuff@comcast.net> <20050603162856.1a80af82.akpm@osdl.org>
In-Reply-To: <20050603162856.1a80af82.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200506031944.20126.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 June 2005 19:28, Andrew Morton wrote:
> Did it work OK under earlier kernels?  If so, which?

2.6.11.x kernels don't have this problem. Problem is sysrq+T traces don't show 
anything relating to the modprobe process, so I am not able to progress with 
debugging. 

Parag
