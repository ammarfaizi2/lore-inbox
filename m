Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288736AbSBOLpd>; Fri, 15 Feb 2002 06:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288614AbSBOLpO>; Fri, 15 Feb 2002 06:45:14 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:53481 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S288127AbSBOLpD>; Fri, 15 Feb 2002 06:45:03 -0500
Date: Fri, 15 Feb 2002 11:44:47 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: how to avoid stale NFS filehandles?
In-Reply-To: <15467.2034.663448.825288@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.44.0202151141510.1457-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm wondering what encoding is used for NFSv{2,3} file handles under
knfsd. In particular, can I upgrade kernel from 2.4.x to 2.4.y without
my clients accumulating stale filehandles?

Cheers,

Matt

