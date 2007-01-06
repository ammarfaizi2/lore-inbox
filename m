Return-Path: <linux-kernel-owner+w=401wt.eu-S1751422AbXAFO5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXAFO5d (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 09:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbXAFO5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 09:57:33 -0500
Received: from www17.your-server.de ([213.133.104.17]:4210 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbXAFO5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 09:57:32 -0500
Message-ID: <459FB89E.5020304@m3y3r.de>
Date: Sat, 06 Jan 2007 15:56:30 +0100
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.9 (X11/20061222)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Rare OOPS in shrink_dcache_for_umount_subtree
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this OOPS while shuting down my computer in function 
shrink_dcache_for_umount_subtree.
For call trace see this picture: m3y3r.de/bilder/img_0359.jpg

I hope somebody can fix this error?!

With kind regards
Thomas

--


