Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUGJGE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUGJGE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUGJGE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:04:59 -0400
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:975 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S266149AbUGJGE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:04:58 -0400
Message-ID: <40EF873A.30603@moving-picture.com>
Date: Sat, 10 Jul 2004 07:05:46 +0100
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Ziegler <mz@newyorkcity.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS no longer working ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Ziegler:
> it's mentioned in Documentation/Changes. When i try to mount i get the 
> message "mount: fs type nfsd not supported by kernel" although NFS is 
> compiled into the kernel. Perhaps there is another option which have to be 
> enabled but i just overseen it ?

Do you have CONFIG_NFSD set?

James Pearson

