Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbRF0BJS>; Tue, 26 Jun 2001 21:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbRF0BJI>; Tue, 26 Jun 2001 21:09:08 -0400
Received: from viper.haque.net ([66.88.179.82]:37796 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S265197AbRF0BJD>;
	Tue, 26 Jun 2001 21:09:03 -0400
Message-ID: <3B393222.14273547@haque.net>
Date: Tue, 26 Jun 2001 21:08:50 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Menage <pmenage@ensim.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
In-Reply-To: <E15F3KH-0003fd-00@pmenage-dt.ensim.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> This could be regarded as the wrong way to solve such a problem, but
> this kind of bug seems to be occurring often enough on BugTraq that it
> might be useful if you don't have the resources to do a full security
> audit on your program (or if the source to some of your libraries
> isn't available).

Why do this in the kernel when it's available in userspace?

http://freshmeat.net/projects/rj/

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
