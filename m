Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbUL3NeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbUL3NeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 08:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUL3NeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 08:34:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:24031 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261391AbUL3NeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 08:34:16 -0500
X-Authenticated: #1425685
Date: Thu, 30 Dec 2004 14:32:28 +0100
From: Sebastian <Ostdeutschland@gmx.de>
To: Lei Ming <LeiMing@HotPop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does "Tainted: P" or "Tainted: GF" mean?
Message-Id: <20041230143228.2f05f288.Ostdeutschland@gmx.de>
In-Reply-To: <41D3FED3.7030909@HotPop.com>
References: <41D3FED3.7030909@HotPop.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 21:12:51 +0800
Lei Ming <LeiMing@HotPop.com> wrote:

> Sorry for asking this silly question:
> 
> When I use lsmod to list all the modules, it displays "Tainted: P",
> and  on my friend's machine it's "Tainted: GF".
> 
> I know what "Tainted" mean, but what does "P" or "GF" mean? If there
> are  others than these two, where can I find a list?
> 
> Thanks.
> 

Hi,

you can find informations about 'tainted kernels' at the end of
Documentation/oops-tracing.txt found in any kernel-source.

Sebastian
