Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWESLi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWESLi3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 07:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWESLi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 07:38:29 -0400
Received: from web52610.mail.yahoo.com ([206.190.48.213]:29074 "HELO
	web52610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932289AbWESLi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 07:38:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dviWSk4FMUlo8aaw1t0yxUKHBJP7nj/eMw2Rlxx5RfkYkPgwYg9U3Qp2b7s3OeHwAb118aYY0IVTbFKNu/MLanzzJzz6US1kRNTLWYiv/nVCYZl+x8KXwpJccDGwczDyjH6gKWsQB3t6ob6ibdL01LrhEewBKOD9BJT+IJZ819M=  ;
Message-ID: <20060519113827.67113.qmail@web52610.mail.yahoo.com>
Date: Fri, 19 May 2006 21:38:27 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: Multi-threaded Program & Strace Problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry to reply to my own email, but there was a
typo.]

--- Srihari Vijayaraghavan
<sriharivijayaraghavan@yahoo.com.au> wrote:
> 1. $ for seq `900`; do echo localhost >> hosts.txt;
> done

Oops. It ought to read:
$ for i in `seq 900`; do echo localhost >> hosts.txt;
done

Rest remain the same.

Sorry for the trouble.

Thanks



		
____________________________________________________ 
On Yahoo!7 
Dating: It's free to join and check out our great singles! 
http://www.yahoo7.com.au/personals
