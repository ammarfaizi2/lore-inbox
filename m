Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbTILDM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 23:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTILDM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 23:12:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38861 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261340AbTILDM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 23:12:58 -0400
Message-ID: <3F6139AD.6070603@pobox.com>
Date: Thu, 11 Sep 2003 23:12:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Andries Brouwer <aebr@win.tue.nl>, Jakub Jelinek <jakub@redhat.com>,
       Dan Aloni <da-x@gmx.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
Subject: Re: [BK PATCH] One strdup() to rule them all
References: <20030912030305.6C1442C089@lists.samba.org>
In-Reply-To: <20030912030305.6C1442C089@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> No.  We've been here.  There are only around 50 users/potential users
> of such a thing in the kernel, and seven implementations, but Linus
> doesn't like it, so let's not waste more time on this please.


Of course, if we DO waste time on it, your implementation Rusty kicks 
ass and takes steroids :)

	Jeff


