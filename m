Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283442AbRLMGAo>; Thu, 13 Dec 2001 01:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283445AbRLMGAe>; Thu, 13 Dec 2001 01:00:34 -0500
Received: from rj.SGI.COM ([204.94.215.100]:5316 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S283442AbRLMGAU>;
	Thu, 13 Dec 2001 01:00:20 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rob Hensley <zoid@zoid.staticky.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: debian unstable and 2.4.16-pre8... 
In-Reply-To: Your message of "Wed, 12 Dec 2001 23:07:26 CDT."
             <Pine.LNX.4.33.0112122304310.22056-200000@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Dec 2001 17:00:07 +1100
Message-ID: <24599.1008223207@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001 23:07:26 -0500 (EST), 
Rob Hensley <zoid@zoid.staticky.com> wrote:
>here's my .config

No chance!  That .config has CONFIG_PCMCIA=n but you are reporting a
bug against pcmcia.o.  Supply the correct config.

