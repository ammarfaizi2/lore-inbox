Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWHCTLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWHCTLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWHCTLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:11:33 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50569 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932214AbWHCTLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:11:32 -0400
Date: Thu, 3 Aug 2006 15:11:00 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hans Reiser <reiser@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: 2.6.18-rc3 - ReiserFS - warning: vs-8115: get_num_ver: not directory or indirect item
Message-ID: <20060803191100.GF19267@filer.fsl.cs.sunysb.edu>
References: <9a8748490607300608v65ce3bdcsbb47273bb82a2d6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490607300608v65ce3bdcsbb47273bb82a2d6c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 03:08:32PM +0200, Jesper Juhl wrote:
> I just got a warning message with 2.6.18-rc3 that I've never seen before :
> 
>  ReiserFS: sda4: warning: vs-8115: get_num_ver: not directory or indirect 
>  item
 
I have seen the same message (if I remember correctly) on my laptop whenever
I tried to _compile_ the nvidia driver - it wasn't loaded yet. A switch to
XFS made it go away ;)
 
Jeff.

-- 
Bus Error: passangers dumped.
