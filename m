Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUCVPip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUCVPip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:38:45 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:33291 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262065AbUCVPin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:38:43 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org, piotr@larroy.com
Subject: Re: 2.6.5-rc1-mm1
Date: Mon, 22 Mar 2004 16:38:00 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040316015338.39e2c48e.akpm@osdl.org> <20040322125305.GA2306@larroy.com>
In-Reply-To: <20040322125305.GA2306@larroy.com>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403221638.01029@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 March 2004 13:53, Pedro Larroy wrote:


Hi Pedro,

> I think I have an abnormal memory situation, seems all my ram got exhausted
> and I don't see it used by userland processes.

yeah, I've experienced the same here. My machine starts to swap _very_ early 
where previous -mm tree's (imho 2.6.4-mm'ish) worked fine.

Sorry, no time atm to check this further :(

ciao, Marc
