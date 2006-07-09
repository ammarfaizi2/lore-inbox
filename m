Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWGIR10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWGIR10 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 13:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWGIR10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 13:27:26 -0400
Received: from mail.gmx.de ([213.165.64.21]:2694 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964898AbWGIR1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 13:27:24 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm1
Date: Sun, 9 Jul 2006 19:28:07 +0200
User-Agent: KMail/1.9.3
References: <20060709021106.9310d4d1.akpm@osdl.org>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607091928.07179.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 9. July 2006 11:11, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
>8-rc1/2.6.18-rc1-mm1/

There are stil problems with initializing the bt878 chip. I'm not sure 
if it is the same bug, but I had problems with all -mm versions since 
2.6.17-mm1
Screenshot: 
http://stud4.tuwien.ac.at/~e0227135/kernel/060709_190546.jpg

I'm sorry about the quality, but I have only a mobile here.

hth,
dominik
