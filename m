Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbUJXOlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUJXOlz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUJXOlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:41:55 -0400
Received: from mail.lindows.com ([130.94.123.204]:50148 "EHLO mail.lindows.com")
	by vger.kernel.org with ESMTP id S261503AbUJXOlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:41:53 -0400
Message-ID: <417BBF32.7050808@linspireinc.com>
Date: Sun, 24 Oct 2004 07:41:54 -0700
From: Clifford Beshers <clifford.beshers@linspireinc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040525 Debian/1.6-5.1.0.50.lindows0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org> <4179425A.3080903@namesys.com>
In-Reply-To: <4179425A.3080903@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Lindows-Footer: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hans Reiser wrote:

> Lindows is planning on shipping with reiser4 in its next release. I 
> would very much like to see our inclusion before that.

Yes, and we would very much like to see it in the mainstream kernel, 
rather than an mm branch.   It is perfectly acceptable to turn off the 
namespace features and trim anything else that might introduce 
incompatibility or instability.  Our goal is to ship it as an advanced 
but integrated feature, i.e., we do not want to ship two kernels and/or 
lose other features such as bootsplash, software suspend, etc.
--

This message contains information which may be confidential and privileged. Unless you are the 
addressee (or authorized to receive for the addressee), you may not use, copy or disclose to anyone 
the message or any information contained in the message. If you have received the message in error, 
please advise the sender and delete the message.  Thank you.
