Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTJUOka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 10:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTJUOk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 10:40:29 -0400
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:36046 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263126AbTJUOk2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 10:40:28 -0400
Message-ID: <3F9545A3.2010405@stesmi.com>
Date: Tue, 21 Oct 2003 16:41:39 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test8] Difference between Software Suspend and Suspend-to-disk?
References: <200310211315.58585.lkml@kcore.org> <20031021113444.GC9887@louise.pinerecords.com> <yw1xy8veddj7.fsf@kth.se>
In-Reply-To: <yw1xy8veddj7.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Tomas Szepe <szepe@pinerecords.com> writes:
> 
> 
>>>Software Suspend (EXPERIMENTAL)
>>>Suspend-to-Disk Support
>>
>>They're competing implementations of the same mechanism.
> 
> 
> And neither one works reliably, I might add.  They both appear to save
> the current state to disk, but no matter what I try, I can't make it
> resume properly.
> 

That's why it's called Software Suspend and Suspend-to-Disk.
The matching components Software Resume and Resume-from-Disk
don't work yet :)

// Stefan

