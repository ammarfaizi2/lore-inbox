Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264928AbUE2ORj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbUE2ORj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUE2ORj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:17:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11464 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264928AbUE2ORh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:17:37 -0400
Date: Sat, 29 May 2004 16:17:31 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Artemio <theman@artemio.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: error compiling linux-2.6.6 and 2.6.7-cr1
Message-ID: <20040529141731.GQ16099@fs.tum.de>
References: <200405291424.43982.theman@artemio.net> <200405291544.10132.theman@artemio.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405291544.10132.theman@artemio.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 04:33:48PM +0300, Artemio wrote:

> I just patched the kernel up to 2.6.7-rc 1 but got the same error, both on gcc 
> 3.3.2 and gcc 2.96.

Sorry if my answer was to technical.

Workaround for your problem:

Enable:

  Device Drivers
    Networking support
      Networking support


> Artemio.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

