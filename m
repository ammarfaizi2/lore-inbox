Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTDRUv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 16:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTDRUv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 16:51:26 -0400
Received: from zeus.kernel.org ([204.152.189.113]:34044 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263239AbTDRUvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 16:51:25 -0400
Date: Fri, 18 Apr 2003 16:54:03 -0400
From: Nick Orlov <bugfixer@list.ru>
To: Andrei Ivanov <andrei.ivanov@ines.ro>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4
Message-ID: <20030418205403.GA3366@nikolas>
Mail-Followup-To: Andrei Ivanov <andrei.ivanov@ines.ro>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50L0.0304182236480.1931-100000@webdev.ines.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L0.0304182236480.1931-100000@webdev.ines.ro>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 10:37:19PM +0300, Andrei Ivanov wrote:
> 
> 
> ... and I think there is another problem, but I can't really verify this, 
> because I'm not near the machine now, so if somebody else could confirm 
> this, it would be great (I hope I'm not getting paranoid :). It seems I 
> can't ssh into that machine:
> 

[[ ... skipped ... ]]

> 
> Here it hangs... on mm1 I was able to connect with ssh to that machine.

In my case sshd was not able to allocate pts...
Actually it was not possible to allocate pts under 2.5.67-mm4 at all.

Not sure if it's the same problem, but it makes 2.5.67-mm4 pretty useless :(

-- 
With best wishes,
	Nick Orlov.

