Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbTFEBKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 21:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbTFEBKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 21:10:14 -0400
Received: from leviathan.ele.uri.edu ([131.128.51.64]:45765 "EHLO
	leviathan.ele.uri.edu") by vger.kernel.org with ESMTP
	id S264344AbTFEBKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 21:10:13 -0400
From: mingz <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: linux-kernel@vger.kernel.org
Subject: io performance monitoring under linux
Date: Wed, 4 Jun 2003 21:12:38 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306042112.38994.mingz@ele.uri.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder why Linux do not have a good performance monitoring facility in 
kernel. For example, there are no place in /proc to read counters like page 
cache, dcache hit ratio, disk queue length,, etc. does such info and tool 
already existed? thx.


(i am not on this list, so pls cc to me as well, thx)


ming


