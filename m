Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269277AbUICVVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269277AbUICVVM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269801AbUICVTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:19:08 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:32075 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269798AbUICVP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:15:56 -0400
Message-ID: <7f800d9f040903141520788d71@mail.gmail.com>
Date: Fri, 3 Sep 2004 14:15:49 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040903133336.6d3b86b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040903014811.6247d47d.akpm@osdl.org>
	 <7f800d9f04090310562cb7015@mail.gmail.com>
	 <20040903133336.6d3b86b8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004 13:33:36 -0700, Andrew Morton <akpm@osdl.org> wrote:
> patch -R -p1 -i acpi-based-i8042-keyboard-aux-controller-enumeration.patch

Thanks, reversing that patch fixed the problem. Kernel is running fine now.

Thanks,
   Andre
