Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTDFSql (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 14:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTDFSql (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 14:46:41 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:28866 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S263125AbTDFSqk (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 14:46:40 -0400
Message-ID: <3E907B06.6000303@kegel.com>
Date: Sun, 06 Apr 2003 12:07:50 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] new syscall: flink
References: <3E907A94.9000305@kegel.com>
In-Reply-To: <3E907A94.9000305@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> How does this differ from fattach() in SuSv3
> (http://www.opengroup.org/onlinepubs/007904975/functions/fattach.html)?

Answering my own dumb question: fattach() is like mount, not ln.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

