Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263414AbTDMKRa (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 06:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTDMKR3 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 06:17:29 -0400
Received: from smtp.hccnet.nl ([62.251.0.13]:34978 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S263414AbTDMKR3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 06:17:29 -0400
Message-ID: <3E993C54.40805@hccnet.nl>
Date: Sun, 13 Apr 2003 12:30:44 +0200
From: Gert Vervoort <gert.vervoort@hccnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67: ppa driver & preempt == oops
References: <3E982AAC.3060606@hccnet.nl> <1050172083.2291.459.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>I guess you don't see these without kernel preemption?
>  
>
I've not tried that for 2.5.67, but with previous 2.5 versions I had no 
problems when I disabled the ppa driver or preemption.

>These are not errors, just warnings.  Most likely you only see them when
>CONFIG_PREEMPT is enabled, because otherwise the kernel cannot detect
>them.  But they still happen.
>
>Does anything go wrong?  Or just these errors?
>  
>

With 2.5.67 it is just these messages, the system continues working. 
Because of these messages I've not tried if the zip-driver functions 
properly.

  Gert


