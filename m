Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279856AbRKFSZg>; Tue, 6 Nov 2001 13:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279875AbRKFSZ0>; Tue, 6 Nov 2001 13:25:26 -0500
Received: from mustard.heime.net ([194.234.65.222]:5801 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S279856AbRKFSZT>; Tue, 6 Nov 2001 13:25:19 -0500
Date: Tue, 6 Nov 2001 19:25:18 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: __FD_SETSIZE question
Message-ID: <Pine.LNX.4.30.0111061921580.24965-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I heard the __FD_SETSIZE setting limits the number of open files to a
process... Is this the fact? What happens if I double it?

Thanks

roy
--
from /usr/src/linux/include/linux/posix_types.h

#define __FD_SETSIZE    1024
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


