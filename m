Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284607AbRLETfQ>; Wed, 5 Dec 2001 14:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284610AbRLETfH>; Wed, 5 Dec 2001 14:35:07 -0500
Received: from sal.qcc.sk.ca ([198.169.27.3]:44294 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S280980AbRLETev>;
	Wed, 5 Dec 2001 14:34:51 -0500
Date: Wed, 5 Dec 2001 13:34:44 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbol memset
Message-ID: <20011205133444.D31095@qcc.sk.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0112051024340.22241-100000@dragon.pdx.osdl.net> <00a501c17dbe$7a6fa580$4d129c87@agere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <00a501c17dbe$7a6fa580$4d129c87@agere.com>; from smithmg@agere.com on Wed, Dec 05, 2001 at 01:55:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Smith <smithmg@agere.com> wrote:
> That particular header is included.
[...]
> #include <memory.h>
> #include <string.h>
> #include "myownheaders.h"

That's not what Randy asked was included.  He said:

> > However-- does the problem source file have
> > #include <linux/string.h>
> > in it?  It should.

Very, very different.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
