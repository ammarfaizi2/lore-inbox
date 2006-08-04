Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWHDBDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWHDBDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 21:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWHDBDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 21:03:51 -0400
Received: from terminus.zytor.com ([192.83.249.54]:55276 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030272AbWHDBDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 21:03:51 -0400
Message-ID: <44D29C45.4070601@zytor.com>
Date: Thu, 03 Aug 2006 18:00:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: Userspace visible of 3 include/asm/ headers
References: <20060803193952.GF25692@stusta.de> <20060803194410.GC16927@redhat.com> <44D26A8B.9040907@zytor.com> <20060803215230.GI25692@stusta.de> <44D28C0A.905@zytor.com> <20060804001221.GM25692@stusta.de>
In-Reply-To: <20060804001221.GM25692@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nevermind, I just realized I did a brainfart.  setup.h should all be 
exported.

	-hpa

