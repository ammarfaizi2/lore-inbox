Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263782AbUELVdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbUELVdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUELVdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:33:04 -0400
Received: from mail.broadpark.no ([217.13.4.2]:62887 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S263782AbUELVct convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:32:49 -0400
To: Mathieu Chouquet-Stringer <mathieu@newview.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Assembler warnings on Alpha
References: <yw1x1xlpv0pj.fsf@kth.se> <xlthdulpdcl.fsf@shookay.newview.com>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Wed, 12 May 2004 23:32:50 +0200
In-Reply-To: <xlthdulpdcl.fsf@shookay.newview.com> (Mathieu
 Chouquet-Stringer's message of "12 May 2004 17:03:38 -0400")
Message-ID: <yw1xwu3htjp9.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Chouquet-Stringer <mathieu@newview.com> writes:

> mru@kth.se (Måns Rullgård) writes:
>> When building Linux 2.6.6 on Alpha, I get numerous of these warnings:
>> 
>> {standard input}:6: Warning: setting incorrect section attributes for .got
>> 
>> What's going on?  I'm using gcc 3.3.3 and binutils 2.15.90.  Are these
>> not good?  Is the resulting kernel safe to boot?
>
> Mine boots and the box has been up for few days now...

Sounds promising.  I guess I'll just give it a try.  Now, does anyone
know what causes those warnings?

-- 
Måns Rullgård
mru@kth.se
