Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbRE2UFM>; Tue, 29 May 2001 16:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbRE2UFC>; Tue, 29 May 2001 16:05:02 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:32179 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S261685AbRE2UEu>;
	Tue, 29 May 2001 16:04:50 -0400
Date: Tue, 29 May 2001 16:04:43 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
X-X-Sender: <fxian@tiger>
To: <linux-kernel@vger.kernel.org>
Subject: share memory between kernel and user space
Message-ID: <Pine.LNX.4.33.0105291601160.28063-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any way to share a piece of memory which is allocated in kernel
space with a user space program? (don't use copy_to_user etc.)

Thanks,

Alex

-- 
        Feng Xian
   _o)     .~.      (o_
   /\\     /V\      //\
  _\_V    // \\     V_/_
         /(   )\
          ^^-^^
           ALEX

