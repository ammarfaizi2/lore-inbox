Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVCCJGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVCCJGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVCCJGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:06:48 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:34748 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261673AbVCCJEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:04:54 -0500
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 3 Mar 2005 01:04:46 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: proc/locaavg definition
Message-ID: <Pine.LNX.4.62.0503030100550.28740@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from what I have been able to find under /Documentation /proc/loadavg is 
defined as giving three loadaverage numbers, 1 min, 5 min, 15 min.

however as of 2.6.5ish timeframe there are a coupld of additional colums 
that do not appear to be documented

the first is something #/# that could be # of running processes/total # of 
processes, but I can't find a definition of this anywhere

the second new column I don't have any clue what it is.

is there some missing documentation or did I miss something in the 
existing documentation, and if so where should I look?

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
