Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTEFNNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbTEFNNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:13:34 -0400
Received: from m029-045.nv.iinet.net.au ([203.217.29.45]:49284 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP id S263309AbTEFNNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:13:33 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 just doesn't boot (neither does anything > .67)
In-Reply-To: <20030506125726.GH20419@wiggy.net> (Wichert Akkerman's message
 of "Tue, 6 May 2003 14:57:26 +0200")
References: <20030506124249.GG20419@wiggy.net>
	<Pine.LNX.4.44.0305062230420.2201-100000@bad-sports.com>
	<20030506125726.GH20419@wiggy.net>
From: Daniel Pittman <daniel@rimspace.net>
Date: Tue, 06 May 2003 23:26:02 +1000
Message-ID: <87u1c8w6j9.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Wichert Akkerman wrote:
> Previously Brett wrote:

[...]

>> and anyway, can you provide any backup that this will fix it ?? what
>> changed between 2.5.66 and 2.5.67 to stop grub loading the kernel ? 
>> why hasn't anyone else reported this ???
> 
> I couldn't boot 2.5 at all until I upgraded an ancient grub. Having
> a recent bootloader is never a bad thing though, and 0.92 is pretty
> old.

0.92 is successfully booting 2.5.6[89] here, and 0.93 (Debian or
upstream) fails to boot on most of my machines here.

YMMV, of course, but 0.92 works for me.

      Daniel

-- 
Don't join the book burners. Don't think you are going to conceal faults by
concealing evidence they ever existed.
        -- Dwight D. Eisenhower
