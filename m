Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbRDXUin>; Tue, 24 Apr 2001 16:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135739AbRDXUid>; Tue, 24 Apr 2001 16:38:33 -0400
Received: from marvin.cdf.toronto.edu ([128.100.31.3]:21730 "HELO
	marvin.cdf.toronto.edu") by vger.kernel.org with SMTP
	id <S130471AbRDXUiR>; Tue, 24 Apr 2001 16:38:17 -0400
Date: Tue, 24 Apr 2001 16:38:10 -0400 (EDT)
From: <apark@cdf.toronto.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.19 and file lock on NFS?
Message-ID: <Pine.LNX.4.30.0104241633490.19976-100000@penguin.cdf.toronto.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently upgraded to 2.2.19, along with new nfs-utils(0.3.1).
But I have a program that requires a exclusive write lock
on a NFSed directory.  When I was using 2.2.17 all was ok,
but now it returns ENOLCK.  Does anybody else have the
same problem?
Thanks

-Andrew

