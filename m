Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUE3J7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUE3J7M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 05:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUE3J7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 05:59:12 -0400
Received: from ppp46-ax.noc.teithe.gr ([195.251.120.46]:30081 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S261991AbUE3J7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 05:59:11 -0400
From: V13 <v13@priest.com>
To: linux-kernel@vger.kernel.org
Subject: process name inconsistency
Date: Sun, 30 May 2004 13:00:40 +0300
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405301300.40853.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this has been discussed before but I believe that having
process names (even for kernel threads) that contain the / character is really 
inconsistent...

<<V13>>
