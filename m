Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbTBVBiC>; Fri, 21 Feb 2003 20:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267760AbTBVBiC>; Fri, 21 Feb 2003 20:38:02 -0500
Received: from services.cam.org ([198.73.180.252]:60531 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267758AbTBVBiC>;
	Fri, 21 Feb 2003 20:38:02 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.62-mm2
Date: Fri, 21 Feb 2003 20:48:09 -0500
User-Agent: KMail/1.5.9
References: <20030220234733.3d4c5e6d.akpm@digeo.com>
In-Reply-To: <20030220234733.3d4c5e6d.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302212048.09802.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 21, 2003 02:47 am, Andrew Morton wrote:
> So this tree has three elevators (apart from the no-op elevator).  You can
> select between them via the kernel boot commandline:
>
>         elevator=as
>         elevator=cfq
>         elevator=deadline

Has anyone been having problems booting with 'as'?  It hangs here at the point
root gets mounted readonly.  cfq works ok.



If this has already been reported sorry - mail is lagging here.

Ed Tomlinson

