Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269502AbUJFUpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269502AbUJFUpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269505AbUJFUpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:45:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:23480 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269502AbUJFUpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:45:17 -0400
Date: Wed, 6 Oct 2004 13:43:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: nickpiggin@yahoo.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Default cache_hot_time value back to 10ms
Message-Id: <20041006134317.03a22198.akpm@osdl.org>
In-Reply-To: <200410062038.i96KcJ608221@unix-os.sc.intel.com>
References: <20041006123959.4cf20b3b.akpm@osdl.org>
	<200410062038.i96KcJ608221@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
>  Secondly, let me ask the question again from the first mail thread:  this value
>  *WAS* 10 ms for a long time, before the domain scheduler.  What's so special
>  about domain scheduler that all the sudden this parameter get changed to 2.5?

So why on earth was it switched from 10 to 2.5 in the first place?

Please resend the final patch.
