Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUFYMCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUFYMCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUFYMCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:02:37 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:49059 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S266730AbUFYMBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:01:52 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
In-Reply-To: <40DC1192.7030006@comcast.net>
References: <40DB605D.6000409@comcast.net> <40DBED77.6090704@hist.no> <40DC0CE0.6040509@comcast.net> <20040625114105.GA28892@infradead.org> <20040625114105.GA28892@infradead.org> <40DC1192.7030006@comcast.net>
Message-Id: <E1BdpOx-0004zz-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Fri, 25 Jun 2004 13:01:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David van Hoose wrote:

>I have ext3 partitions, so I decided if they are different partitions, 
>then I can compile my kernel with ext2 as a module and ext3 builtin.
>So I do it and reboot. Panic! Reason? Cannot find filesystem for the 
>root partition.

Are you really, really, really sure that your root partition is ext3?
Really?

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
