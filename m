Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTEZXwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTEZXwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:52:30 -0400
Received: from pop.gmx.net ([213.165.65.60]:36184 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262367AbTEZXw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:52:29 -0400
Message-ID: <3ED2ABD0.7090805@gmx.net>
Date: Tue, 27 May 2003 02:05:36 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk19 "make" messages much less informative
References: <200305262223.h4QMN5D12796@adam.yggdrasil.com> <20030526224949.GA27375@compsoc.man.ac.uk>
In-Reply-To: <20030526224949.GA27375@compsoc.man.ac.uk>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> On Mon, May 26, 2003 at 03:23:05PM -0700, Adam J. Richter wrote:
> 
> 
>>	2.5.69-bk19 dumbs down the messages from make into a format
> 
> 
> You can use make V=1 (I hope) to get the proper behaviour back
> 
> 
>>	This is much less informative than seeing the actual CC commands.
> 
> 
> I completely agree. A step backwards :( V=0 is certainly useful but it
> shouldn't be the default. You can't force people to pay attention to
> warnings, only encourage them...

If something stands out clearly, people tend to notice it. Assuming only
one person gets annoyed enough to submit fixes for the warnings, this is
a net win.
V=0 still works, only the default was changed.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

