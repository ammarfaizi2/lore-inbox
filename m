Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbWFIXJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWFIXJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWFIXJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:09:55 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:49320 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932300AbWFIXJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:09:54 -0400
Message-ID: <4489FFB8.3070203@garzik.org>
Date: Fri, 09 Jun 2006 19:09:44 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, Dave Jones <davej@redhat.com>,
       Theodore Tso <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609205036.GI7420@redhat.com> <4489E8EF.5020508@garzik.org> <20060609225604.GK5964@schatzie.adilger.int>
In-Reply-To: <20060609225604.GK5964@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Maybe we should start by deleting ext2 because it is old and obsolete?
> The reality is that we will never merge the forks back once they are made.

We _already have_ a relevant example:  ext2 -> ext3.

A useful fork is in the tree, and you're working on it.

	Jeff


