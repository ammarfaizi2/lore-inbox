Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316049AbSENU6H>; Tue, 14 May 2002 16:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSENU6H>; Tue, 14 May 2002 16:58:07 -0400
Received: from leftcoast.thebackrow.net ([64.94.89.22]:18447 "EHLO
	leftcoast.thebackrow.net") by vger.kernel.org with ESMTP
	id <S316049AbSENU6G>; Tue, 14 May 2002 16:58:06 -0400
Date: Tue, 14 May 2002 13:58:06 -0700
To: linux-kernel@vger.kernel.org
Subject: 2.4.19, console.h and wait_key()
Message-ID: <20020514205806.GA4080@thebackrow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Will Lowe <harpo@thebackrow.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like wait_key() was been remove from the console struct in
linux/console.h in 2.4.19-pre7.  Anybody know why?  Google, an archive
search of this list, and the Changelogs don't seem to have any
information.

-- 
					thanks,
		
					Will
