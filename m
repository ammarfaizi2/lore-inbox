Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269135AbUJKRxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269135AbUJKRxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 13:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269143AbUJKRxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 13:53:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39667 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269135AbUJKRxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 13:53:20 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, sdietrich@mvista.com,
       linux-kernel@vger.kernel.org, abatyrshin@ru.mvista.com,
       amakarov@ru.mvista.com, emints@ru.mvista.com, ext-rt-dev@mvista.com,
       hzhang@ch.mvista.com, yyang@ch.mvista.com
In-Reply-To: <20041010215906.GA19497@elte.hu>
References: <41677E4D.1030403@mvista.com> <20041010084633.GA13391@elte.hu>
	 <1097437314.17309.136.camel@dhcp153.mvista.com>
	 <20041010142000.667ec673.akpm@osdl.org>  <20041010215906.GA19497@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1097517191.28173.1.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Oct 2004 10:53:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-10 at 14:59, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Lockmeter gets in the way of all this activity in a big way.  I'll
> > drop it.
> 
> great. Daniel, would you mind to merge your patchkit against the
> following base:
> 
> 	-mm3, minus lockmeter, plus the -T3 patch


No problem. Next release will be without lockmeter. Thanks for the
patches.



Daniel Walker



