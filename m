Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311863AbSCNXQw>; Thu, 14 Mar 2002 18:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311861AbSCNXQm>; Thu, 14 Mar 2002 18:16:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45061 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311863AbSCNXQc>; Thu, 14 Mar 2002 18:16:32 -0500
Subject: Re: Will XFree86-4.2.0 dri modules come to 2.4.x kernel?
To: haiquy@yahoo.com (=?iso-8859-1?q?Steve=20Kieu?=)
Date: Thu, 14 Mar 2002 23:32:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <20020314230658.50980.qmail@web10401.mail.yahoo.com> from "=?iso-8859-1?q?Steve=20Kieu?=" at Mar 15, 2002 10:06:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16leho-0002Et-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> XFree86-4.2.0 is out. Would the dri kernel modules for
> XFree86-4.2.0  be  included into the kernel ? I can
> not have 3D running wiht the modules for XFree86-4.1.0
> while running 4.2.0. 

All the modules should be compatible, except for the I830M which requires
a new module not in XFree 4.1/DRM 4.1

The 4.2 modules are merged in 2.4.19-ac, but have rmap dependancies so I
can't push my versions on to Marcelo.

Alan

