Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVBNAXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVBNAXV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 19:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVBNAXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 19:23:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26527 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261324AbVBNAXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 19:23:17 -0500
Message-ID: <420FEF73.30908@sgi.com>
Date: Sun, 13 Feb 2005 18:23:15 -0600
From: Josh Aas <josha@sgi.com>
Reply-To: josha@sgi.com
Organization: Silicon Graphics, Inc.
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.8.1 CPU Scheduler Documentation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have written an introduction to the Linux 2.6.8.1 CPU scheduler 
implementation. It should help people to understand what is going on in 
the scheduler code faster than they would be able to by just reading 
through the code. The paper can be downloaded in PDF or LyX form from here:

http://josh.trancesoftware.com/linux/

This paper will never be "done," as I'd like to keep improving it over 
time, and updating it to newer versions of the kernel as time allows. If 
you have comments, suggestions, or corrections you'd like to make, 
please email me. Technical corrections in particular would be 
appreciated. Hopefully this can be as accurate and helpful as possible, 
and will inspire more people to look into the Linux scheduler.

My employer, SGI, did not ask me to write this paper - it was done as 
part of a school project last semester. While SGI owns the copyright to 
the paper, they have allowed me to release it under the GNU FDL.

-- 
Josh Aas
Linux System Software
Silicon Graphics, Inc. (SGI)

