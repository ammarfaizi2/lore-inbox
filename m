Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310696AbSCHG0P>; Fri, 8 Mar 2002 01:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310697AbSCHG0F>; Fri, 8 Mar 2002 01:26:05 -0500
Received: from [159.226.92.9] ([159.226.92.9]:7180 "EHLO lsec.cc.ac.cn")
	by vger.kernel.org with ESMTP id <S310696AbSCHGZ7>;
	Fri, 8 Mar 2002 01:25:59 -0500
Date: Fri, 8 Mar 2002 14:25:09 +0800 (CST)
From: Zhang Lin-bo <zlb@lsec.cc.ac.cn>
To: fooooobar@hotmail.com
cc: linux-kernel@vger.kernel.org
Subject: Re: i810_audio support
Message-ID: <Pine.LNX.4.44.0203081408380.23704-100000@lsec.cc.ac.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had encountered the same problem with my Fujitsu LBS5582,
and I found out that the crackling was caused by the esound
daemon. For example, if I change the output plugin of xmms
from libesdout.so to libOSS.so, the crackling's gone.
Maybe this is also your case?

--


