Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWFTMcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWFTMcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWFTMcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:32:47 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:28775 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965121AbWFTMcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:32:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yGCAp4CLsavi+qbfasH6l6RxwPg6i1CbkxwjtJ/LFh0faVWtTZL3Ubj3a1R8gbk0lrM728FpdYZnyCcpFgjL3GfGdyzZQELTBtccyLd/3lnoPdUTalcy5QPA4GhVHkBwXt+59yo86fRm0WutFYsdGco3U7jjwpxZlGQnAFpfqFc=  ;
Message-ID: <4497EAC6.3050003@yahoo.com.au>
Date: Tue, 20 Jun 2006 22:32:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Whitehouse <swhiteho@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
In-Reply-To: <1150805833.3856.1356.camel@quoit.chygwyn.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Whitehouse wrote:
> Hi,
> 
> Linus, Andrew suggested to me to send this pull request to you directly.
> Please consider merging the GFS2 filesystem and DLM from (they are both
> in the same tree for ease of testing):
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6.git
> 
> They have both lived in -mm for quite some time. We merged all review
> feedback and patches that came though -mm and from the various previous
> postings of patches to lkml and fsdevel mailing lists.
> 
> I have updated my git tree so that its fully uptodate with your current
> tree (as of the time of this request) and tested building and using it,

Hi Steve,

Could you post a diffstat?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
