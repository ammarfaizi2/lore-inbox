Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271208AbRHZBcK>; Sat, 25 Aug 2001 21:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271232AbRHZBb7>; Sat, 25 Aug 2001 21:31:59 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:12051 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271213AbRHZBbu>;
	Sat, 25 Aug 2001 21:31:50 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Clemens Kirchgatterer <clemens@root.at>
cc: linux-kernel maillinglist <linux-kernel@vger.kernel.org>
Subject: Re: maybe OT: segfault on insmod 
In-Reply-To: Your message of "Sat, 25 Aug 2001 17:23:23 +0200."
             <3B87C2EB.6DD2593F@root.at> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 Aug 2001 11:31:59 +1000
Message-ID: <13558.998789519@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001 17:23:23 +0200, 
Clemens Kirchgatterer <clemens@root.at> wrote:
>FYI: saa7146_core.o and dvb.o are modules comeing with the dvb (digital
>video broadcast) driver for linux>=2.4.3
>insmod is not able to load the modules  correctly. they
>show up when i do lsmod but have a (initializing) before the [used by].

The dvb code is failing at startup.  Ask the dvb maintainers.

