Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280073AbRKEAkB>; Sun, 4 Nov 2001 19:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280074AbRKEAjl>; Sun, 4 Nov 2001 19:39:41 -0500
Received: from mnh-1-01.mv.com ([207.22.10.33]:37388 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S280081AbRKEAjg>;
	Sun, 4 Nov 2001 19:39:36 -0500
Message-Id: <200111050158.UAA05147@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Lonnie Cumberland <lonnie@outstep.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification 
In-Reply-To: Your message of "Sun, 04 Nov 2001 19:01:48 EST."
             <3BE5D6EC.8040204@outstep.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Nov 2001 20:58:28 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lonnie@outstep.com said:
> My problem is that I need to find a way to prevent the user from
> navigating out of their home directories. 

A virtual machine would be an administratively easy way of doing this.

Let the 'app' be a VM with the real apps installed inside.  The users would
effectively be confined to a *file* on the host, not merely their home
directories.

My (biased :-) recommendation would be User-mode Linux 
(http://user-mode-linux.sourceforge.net), but VMWare would work as
well.

				Jeff

