Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264101AbRFSJmM>; Tue, 19 Jun 2001 05:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264103AbRFSJmD>; Tue, 19 Jun 2001 05:42:03 -0400
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:55290 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264101AbRFSJlx>; Tue, 19 Jun 2001 05:41:53 -0400
Date: Tue, 19 Jun 2001 10:41:51 +0100 (BST)
From: Jeremy Sanders <jss@ast.cam.ac.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Re: rsync hangs on RedHat 2.4.2 or stock 2.4.4
In-Reply-To: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0106191040230.9988-100000@xpc1.ast.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found a patch which fixes the hanging problem, so I guess it's not
linux-kernel which is at fault. Get it from Wayne Davison at:

 http://www.clari.net/~wayne/rsync-nohang.patch

Jeremy

-- 
Jeremy Sanders <jss@ast.cam.ac.uk>  http://www-xray.ast.cam.ac.uk/~jss/
Pembroke College, Cambridge. UK   Institute of Astronomy, Cambridge. UK


