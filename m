Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTDOQa5 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTDOQa5 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:30:57 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:1796 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261675AbTDOQa5 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 12:30:57 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: BUGed to death
Date: Tue, 15 Apr 2003 18:42:35 +0200
User-Agent: KMail/1.5
References: <20030415143024.GA10117@rushmore> <20030415155708.GB17152@suse.de>
In-Reply-To: <20030415155708.GB17152@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304151842.35624.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 April 2003 17:57, Dave Jones wrote:
> Imagine I pass in 20. Previously, the BUG triggers. Not any more.
> Ditto the other changes.  Or am _I_ missing something ?

Yes ;)
You're missing the (not posted) while loop before. Just look into source.

-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

