Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUJWE0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUJWE0v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUJWE02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:26:28 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:16818 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267624AbUJWEWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:22:55 -0400
Message-ID: <4179DC8F.5050408@yahoo.com.au>
Date: Sat, 23 Oct 2004 14:22:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: John Hawkes <hawkes@oss.sgi.com>
CC: akpm@osdl.org, jbarnes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, 2.6.9] improved load_balance() tolerance for pinned tasks
References: <200410221920.i9MJKeHm024118@oss.sgi.com>
In-Reply-To: <200410221920.i9MJKeHm024118@oss.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Hawkes wrote:
> Nick, your patch doesn't work on my 128p to solve the problem.
> This variation, however, does work.  It's a patch against 2.6.9.
> The difference is in move_tasks().
> 

OK good. I'd be happy with you sending that to Andrew if you're
happy with it.

Thanks,
Nick
