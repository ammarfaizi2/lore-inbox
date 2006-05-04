Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWEDJiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWEDJiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWEDJiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:38:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18447 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751460AbWEDJiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:38:19 -0400
Date: Thu, 4 May 2006 07:32:22 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/13: eCryptfs] Documentation
Message-ID: <20060504073222.GD5359@ucw.cz>
References: <20060504031755.GA28257@hellewell.homeip.net> <20060504033534.GA28613@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504033534.GA28613@hellewell.homeip.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Index: linux-2.6.17-rc3-mm1-ecryptfs/Documentation/ecryptfs.txt
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.17-rc3-mm1-ecryptfs/Documentation/ecryptfs.txt	2006-05-02 19:36:04.000000000 -0600
> @@ -0,0 +1,76 @@
> +
> +This software is currently undergoing development. Make sure to
> +maintain a backup copy of any data you write into eCryptfs.

Hehe, and encrypt backup copy with rot13? ;-).

> +The operation will complete.  Notice that there is a new file in
> +/root/crypt that is 2 pages (8192 bytes) in size.  This is the

Not 12K and or 8K+strlen('hello world')?

							Pavel
-- 
Thanks, Sharp!
