Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317265AbSGCWlL>; Wed, 3 Jul 2002 18:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317266AbSGCWlK>; Wed, 3 Jul 2002 18:41:10 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:16602 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317265AbSGCWlJ>; Wed, 3 Jul 2002 18:41:09 -0400
Date: Thu, 4 Jul 2002 00:43:26 +0200
From: Ulrich Wiederhold <U.Wiederhold@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: nvidia driver won't compile with 2.4.19-rc1
Message-ID: <20020703224326.GA2036@sky.net>
References: <20020703214757.GA504@sky.net> <Pine.GSO.4.30.0207040023140.23914-200000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0207040023140.23914-200000@balu>
User-Agent: Mutt/1.4i
X-Operating-System: Debian GNU/Linux 3.0 (Kernel 2.4.19-rc1)
Organization: Using Linux Only
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pozsar Balazs <pozsy@uhulinux.hu> [020704 00:24]:
> 
> actually it compiles but the 'make' fails because of depmod complaining.
> 
> attached patch will help you.

Works, thanks.
I turned off the "Set version information on all module symbols" part.

Uli

-- 
'The box said, 'Requires Windows 95 or better', so i installed Linux - TKK 5
