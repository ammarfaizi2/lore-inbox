Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbTDPAnd (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 20:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTDPAnd 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 20:43:33 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:34445 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264174AbTDPAnd (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 20:43:33 -0400
Date: Tue, 15 Apr 2003 20:49:33 -0400
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Philippe Gramoull? <philippe.gramoulle@mmania.com>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then hard freeze ( lockup on CPU0)
Message-ID: <20030416004933.GI16706@phunnypharm.org>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com> <20030415160530.2520c61c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415160530.2520c61c.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 04:05:30PM -0700, Andrew Morton wrote:
> Philippe Gramoull?  <philippe.gramoulle@mmania.com> wrote:
> >
> > 
> > http://www.philou.org/2.5.67-mm3/2.5.67-mm3.log
> 
> This is a great bug report.  Thanks.
> 
> The 1394 warnings are known about and I think Ben is working on it.

Yeah, they are fixed in the linux1394 tree. I'm getting ready to push
them to Linus.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
