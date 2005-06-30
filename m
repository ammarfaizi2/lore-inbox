Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVF3JWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVF3JWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 05:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVF3JUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 05:20:22 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:49413 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262912AbVF3JUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 05:20:02 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: FUSE merging?
Message-Id: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 Jun 2005 11:19:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

What's up with FUSE merging?  Is there anything pending that I should
do?

Ted Ts'o's ideas about selective access to mountpoints are
interesting, but I wouldn't consider them merge critical, as they
solve a problem, that hasn't yet come up in real life.

Thanks,
Miklos
