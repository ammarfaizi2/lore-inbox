Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVEDErw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVEDErw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 00:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVEDErv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 00:47:51 -0400
Received: from [202.136.32.45] ([202.136.32.45]:16604 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262017AbVEDErt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 00:47:49 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Joe <joecool1029@gmail.com>
Cc: 7eggert@gmx.de, linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Empty partition nodes not created (was device node issues with recent mm's and udev)
Date: Wed, 04 May 2005 14:47:35 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <5nkg71dhkkvbsam7o0b0r828cvadnr4adb@4ax.com>
References: <3ZVNP-5cq-7@gated-at.bofh.it> <E1DTAgo-0002uD-F0@be1.7eggert.dyndns.org> <d4757e600505032049716c811b@mail.gmail.com>
In-Reply-To: <d4757e600505032049716c811b@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2005 23:49:55 -0400, Joe <joecool1029@gmail.com> wrote:
>
>Actually, yes there is.. its a firmware partition that would normally
>not be mounted, but in order to dd new firmware versions to it, I
>depended on the node... which has ceased to exist.

If it is firmware, looks unallocated to other systems, bad things 
might happen if device plugged into windows box?  (Assuming USB) 
You still have 255 numbers to choose from for partition type? :)

--Grant.
