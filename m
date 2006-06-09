Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbWFIUKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbWFIUKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbWFIUKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:10:36 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:10657 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030248AbWFIUKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:10:35 -0400
Message-ID: <4489D5B6.30406@garzik.org>
Date: Fri, 09 Jun 2006 16:10:30 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Michael Poole <mdpoole@troilus.org>,
       Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com>	<4489D36C.3010000@garzik.org> <m3odx25bxz.fsf@bzzz.home.net>
In-Reply-To: <m3odx25bxz.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Jeff Garzik (JG) writes:
> 
>  JG> Rather than taking another decade to slowly fix ext2 design decisions, 
>  JG> why not move the process along a bit more rapidly?  Release early, 
>  JG> release often...
> 
> that could be true, if we were talking about something yet to be
> designed, coded and tested.

'cp ext3 ext4' already has its first two features:  extents and 48bit. 
And it works today.  Tested to the extent that the submittor has tested it.

	Jeff



