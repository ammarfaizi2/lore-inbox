Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTENM6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTENM6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:58:25 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:7342 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S262174AbTENM6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:58:04 -0400
Subject: Re: 2.6 must-fix list, v2
From: Steven Cole <elenstev@mesatop.com>
To: "Shaheed R. Haque" <srhaque@iee.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1052912961.3ec22d4114bd0@netmail.pipex.net>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <1050177383.3e986f67b7f68@netmail.pipex.net>
	 <1050177751.2291.468.camel@localhost>
	 <1050222609.3e992011e4f54@netmail.pipex.net>
	 <1050244136.733.3.camel@localhost>
	 <1052826556.3ec0dbbc1d993@netmail.pipex.net>
	 <20030513130257.78ab1a2e.akpm@digeo.com>
	 <1052865981.3ec175bd59bc9@netmail.pipex.net>
	 <1052880133.21270.131.camel@spc>
	 <1052912961.3ec22d4114bd0@netmail.pipex.net>
Content-Type: text/plain; charset=iso-8859-7
Organization: 
Message-Id: <1052917722.8088.67.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 14 May 2003 07:08:43 -0600
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 05:49, Shaheed R. Haque wrote:
> Quoting Steven Cole <elenstev@mesatop.com>:
> 
> > Is this related or not to processor shielding used by RedHawk Linux?
> > Here is a link to their page:
> > 
> > http://www.ccur.com/realtime/sys_rdhwklnx.html
> > 
> > I saw a presentation by these guys over a year ago.  I'm not sure what
> > they're up to now.
> 
> Yes, if I correctly read the description of this feature, it seems to be the 
> same thing.
> 
Thanks, that is what I suspected.

There seemed to be quite a bit of interest in this from the other
customers, although our facility doesn't presently need this
functionality.  In the spirit of the "squeaky wheel", I'll squeak softly
for them.  

>From the above web page, thus quoth the RedHawk:

"In tightly-coupled symmetric multiprocessing systems such as
Concurrent¢s iHawk real-time systems, RedHawk Linux allows individual
CPUs to be shielded from interrupt processing, daemons, bottom halves,
and other Linux tasks. Processor shielding provides a highly
deterministic execution environment where interrupt response is
guaranteed. RedHawk implements shielding via the industry-accepted
shield(1) command."

Steven

