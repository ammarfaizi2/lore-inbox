Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266268AbUBLEmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 23:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266276AbUBLEmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 23:42:42 -0500
Received: from dictum-ext.geekmail.cc ([204.239.179.245]:47042 "EHLO
	mailer01.geekmail.cc") by vger.kernel.org with ESMTP
	id S266268AbUBLEml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 23:42:41 -0500
Message-ID: <402B0430.10200@swapped.cc>
Date: Wed, 11 Feb 2004 20:42:24 -0800
From: Alex Pankratov <ap@swapped.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] [2/2] hlist: remove IFs from hlist functions
References: <4029CB7E.4030003@swapped.cc.suse.lists.linux.kernel>	<4029CF24.1070307@osdl.org.suse.lists.linux.kernel>	<4029D2D5.7070504@swapped.cc.suse.lists.linux.kernel>	<p73y8ra5721.fsf@nielsen.suse.de>	<402A5CEC.2030603@swapped.cc> <20040214195949.2ad9aa4f.ak@suse.de>
In-Reply-To: <20040214195949.2ad9aa4f.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:
> On Wed, 11 Feb 2004 08:48:44 -0800
> Alex Pankratov <ap@swapped.cc> wrote:
> 
> 
>>Andi Kleen wrote:
> 
> A full cache miss is extremly costly on a modern Gigahertz+ CPU because
> memory and busses are far slower than the CPU core...
[snip]

Thanks for the summary, I did some background reading, you're 100%
right of course. Ignore the patch. Thanks again.

Alex
