Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTDCVMD 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263486AbTDCVMD 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:12:03 -0500
Received: from [12.47.58.55] ([12.47.58.55]:64135 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263484AbTDCVMC 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 16:12:02 -0500
Date: Thu, 3 Apr 2003 13:22:43 -0800
From: Andrew Morton <akpm@digeo.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm2
Message-Id: <20030403132243.7bc9a22d.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.51.0304031947321.16306@dns.toxicfilms.tv>
References: <20030401000127.5acba4bc.akpm@digeo.com>
	<Pine.LNX.4.51.0304031947321.16306@dns.toxicfilms.tv>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Apr 2003 21:23:23.0752 (UTC) FILETIME=[41FC5680:01C2FA27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:
>
> Hi,
> 
> remember my post about the machine locking up for a few seconds?

Could you try 2.5.66-mm3?  It has a CPU scheduler fix which might well help here.


