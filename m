Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130392AbQKXXWD>; Fri, 24 Nov 2000 18:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130436AbQKXXVx>; Fri, 24 Nov 2000 18:21:53 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:11467 "EHLO
        tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
        id <S130392AbQKXXVo>; Fri, 24 Nov 2000 18:21:44 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
Date: Fri, 24 Nov 2000 17:51:37 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.2.18pre21: DRM update
MIME-Version: 1.0
Message-Id: <00112417513700.04460@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> I'll look over it. It may be worth doing the fixing for 2.2.18, since
> 2.2.17 doesnt have DRM anyway. As posted it doesnt build against vanilla
> 2.2.18pre but I can see why so not a problem

This patch enables a G400 to use DRI using debian woody.  Without this its 
2.4 time.  (BTW 2.4.0test11-ac3 BUG()ed out at sched.c:513 when playing the 
the matrox fb stuff).

Ed Tomlinson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
