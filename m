Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUBWJGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUBWJGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:06:47 -0500
Received: from relay.dada.it ([195.110.100.8]:54403 "EHLO relay.dada.it")
	by vger.kernel.org with ESMTP id S261887AbUBWJGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:06:44 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.3-mm1 and aic7xxx
Date: Mon, 23 Feb 2004 10:06:38 +0100
User-Agent: KMail/1.6
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615F2BAD@hdsmsx402.hd.intel.com> <1077521296.12675.81.camel@dhcppc4>
In-Reply-To: <1077521296.12675.81.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402231006.38085.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle Monday 23 February 2004 08:28, Len Brown ha scritto:
>
> Fabio,
> Any chance you can isolate further where this broke by finding the
> latest release where it worked properly?
>
> ie. does vanilla 2.6.3 work if you back out the mm patch?
>
> If 2.6.3 works, then I'd be interested if the following 2.6.3 patch
> breaks it:

[SNIP]

Sure, this evening I'll try to catch the exact last release that worked fine. 
I've used only  mm releases so far, so I've noticed the problem only with 
2.6.3-mm1 and mm2; in a few hours I'll report back for other versions as you 
suggested.


-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

