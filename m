Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTH0QTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbTH0QRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:17:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:57853 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263531AbTH0QQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:16:38 -0400
Subject: Re: Compile problem with CONFIG_X86_CYCLONE_TIMER Re:
	2.6.0-test4-mm1
From: Dave Hansen <haveblue@us.ibm.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, John Stultz <johnstul@us.ibm.com>
In-Reply-To: <20030827160020.GA4119@matchmail.com>
References: <20030827010849.GA5280@matchmail.com>
	 <1061959279.12881.6.camel@nighthawk>  <20030827160020.GA4119@matchmail.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062000944.12879.27.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Aug 2003 09:15:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 09:00, Mike Fedyk wrote:
> On Tue, Aug 26, 2003 at 09:41:19PM -0700, Dave Hansen wrote:
> > On Tue, 2003-08-26 at 18:08, Mike Fedyk wrote:
> > > This patch to my .config makes it compile:
> > 
> > I tried 2.6.0-test4-mm1 with your config and didn't have any problems. 
> > Could you check with your old config to make sure I'm not missing
> > something?
> 
> did you try with gcc 2.95?

Yep.
# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

-- 
Dave Hansen
haveblue@us.ibm.com

