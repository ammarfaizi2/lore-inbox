Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSHRKep>; Sun, 18 Aug 2002 06:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSHRKep>; Sun, 18 Aug 2002 06:34:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:45299 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313628AbSHRKep>; Sun, 18 Aug 2002 06:34:45 -0400
Subject: Re: 2.4.20-pre2-ac3 oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tony Spinillo <tspinillo@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020817225153.73736.qmail@web14003.mail.yahoo.com>
References: <20020817225153.73736.qmail@web14003.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Aug 2002 11:38:27 +0100
Message-Id: <1029667107.15858.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am on a stock RedHat 7.3 system, all updates applied,
> gcc 2.96, modutils 2.4.19. I burned from the
> console and made sure the NVidia module never loaded.
> 

> localhost kernel: EIP:    0010:[<c011853f>]    Tainted: PF

You seem to have something loaded still. 

