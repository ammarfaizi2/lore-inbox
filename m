Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261372AbTCJRNV>; Mon, 10 Mar 2003 12:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbTCJRNV>; Mon, 10 Mar 2003 12:13:21 -0500
Received: from Bacchus.lis.inpg.fr ([195.220.21.21]:6572 "EHLO
	bacchus.lis.inpg.fr") by vger.kernel.org with ESMTP
	id <S261372AbTCJRNQ>; Mon, 10 Mar 2003 12:13:16 -0500
Subject: Judy library faster than
From: Laurent Bonnaud <bonnaud@altern.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1047317035.7788.107.camel@irancy.lis.inpg.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Mar 2003 18:23:55 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently came across this library:

  http://judy.sourceforge.net/

that claims to be several times faster than standard map and hash
implementations thanks to more efficient processor cache use.

Would someone care to compare it to hash map implementations found in
the Linux kernel ?


