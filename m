Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVAGQAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVAGQAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVAGQAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:00:53 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:20826 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S261477AbVAGP7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:59:24 -0500
Date: Fri, 7 Jan 2005 16:59:22 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: uselib()  & 2.6.X?
Message-ID: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


http://isec.pl/vulnerabilities/isec-0021-uselib.txt

[...]
Locally  exploitable  flaws  have  been found in the Linux binary format
loaders'  uselib()  functions  that  allow  local  users  to  gain  root
privileges.
[...]
Version:   2.4 up to and including 2.4.29-rc2, 2.6 up to and including 2.6.10
[...]

It's was fixed by Marcelo on 2.4.29-rc1. Thank's :)
What about 2.6.X? Is any patch available? I don't see any changes 
around binfmt_elf in 2.6.10-bk10?



-- 
*[ £ukasz Tr±biñski ]*
