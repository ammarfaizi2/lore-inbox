Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSJ3EEt>; Tue, 29 Oct 2002 23:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263956AbSJ3EEs>; Tue, 29 Oct 2002 23:04:48 -0500
Received: from bitmover.com ([192.132.92.2]:15310 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263491AbSJ3EEs>;
	Tue, 29 Oct 2002 23:04:48 -0500
Date: Tue, 29 Oct 2002 20:11:10 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
Message-ID: <20021029201110.A29661@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Phillip Lougher <phillip@lougher.demon.co.uk>,
	Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF4DBA.8060005@rackable.com> <3DBF5756.2010702@lougher.demon.co.uk> <3DBF5A08.9090407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DBF5A08.9090407@pobox.com>; from jgarzik@pobox.com on Tue, Oct 29, 2002 at 11:03:20PM -0500
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A r/w compressed filesystem would be darned useful too :)

mmap(2) is, err, hard.  Not impossible, it means the file system has to 
support both compressed and uncompressed files, but it's interesting.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
