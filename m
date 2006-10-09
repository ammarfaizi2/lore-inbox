Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbWJIMyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWJIMyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWJIMyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:54:44 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:47482 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932722AbWJIMyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:54:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Cntu2udVbXYijLmue3rSUvhBi+vf3veoKeffTKzkg07yvrISrP347HuvDfayPrujC1lXJ+jKMa6V5CxFs3vFe7InaAjuPLu9cAwIKV0tScTd5GtLOi/Cs3Petgg2Xa9rtdHHGC2PO4C7GGzQGu9FyRy2w6J+PkDvBjJv2iMcGTk=  ;
Message-ID: <452A469F.7010807@yahoo.com.au>
Date: Mon, 09 Oct 2006 22:54:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 25 random kernel configs, 24 build failures - 2.6.19-rc1-git2
References: <200610071102.05384.jesper.juhl@gmail.com>
In-Reply-To: <200610071102.05384.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> ====================
> 
> kernel/sched.c: In function `domain_distance':
> kernel/sched.c:5673: internal compiler error: Segmentation fault
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://gcc.gnu.org/bugs.html> for instructions.
> make[1]: *** [kernel/sched.o] Error 1
> make: *** [kernel] Error 2
> 
> ====================

-ENOTME ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
