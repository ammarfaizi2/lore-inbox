Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSLJQOu>; Tue, 10 Dec 2002 11:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSLJQOu>; Tue, 10 Dec 2002 11:14:50 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:9664 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262430AbSLJQOt>; Tue, 10 Dec 2002 11:14:49 -0500
Subject: Re: Radeon DRI w/ large memory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Franke <daniel@franke.homeip.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjanv@redhat.com
In-Reply-To: <20021210015423.GA469@silmaril>
References: <20021209224553.GA469@silmaril>  <20021210015423.GA469@silmaril>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 16:56:18 +0000
Message-Id: <1039539378.14175.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 01:54, Daniel Franke wrote:
> Everything seems fine when I use vanilla 2.4.20.  Hightower from #kernelnewbies
> tells me that there is a known bug in -ac with Radeon DRI and 2.4.20-ac1, but
> that as far as he is aware, the bug occurs regardless of the large memory 
> setting.  However, since the bug goes away when I switch to the linus tree, I
> will assume that it is the same bug.  If I see otherwise when the known bug is
> supposedly fixed, I will post further information.

Sounds unrelated. I'm removing the drm update in -ac soon I think. 
