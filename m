Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264078AbTE0S1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTE0S1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:27:13 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:37894 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264078AbTE0S0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:26:35 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 20:39:18 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <20030527182547.GG3767@dualathlon.random> <Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305272039.18330.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 20:33, Marcelo Tosatti wrote:

Hi Marcelo,

> It seems your "fix-pausing" patch is fixing a potential wakeup
> miss, right? (I looked quickly throught it). Could you explain me the
> problem its trying to fix and how?
Please have also a look here:

http://hypermail.idiosynkrasia.net/linux-kernel/archived/2002/week45/0305.html

ciao, Marc

