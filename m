Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262577AbRENXf5>; Mon, 14 May 2001 19:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbRENXfr>; Mon, 14 May 2001 19:35:47 -0400
Received: from intranet.resilience.com ([209.245.157.33]:42479 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S262577AbRENXfl>; Mon, 14 May 2001 19:35:41 -0400
Message-ID: <3B006CC7.AAD065BA@resilience.com>
Date: Mon, 14 May 2001 16:39:51 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Wayne Whitney <whitney@math.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel reports wrong amount of physical memory
In-Reply-To: <Pine.LNX.4.33.0105142025000.18102-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Mon, 14 May 2001, Wayne Whitney wrote:
> > In mailing-lists.linux-kernel, you wrote:
> >
> > > You need to compile highmem support into the kernel if you want to
> > > use more than 890 MB of RAM, set it to maximum 4GB for best
> > > performance...
> >
> > On a similar note, what is the maximum physical memory supported
> > by the 4GB option?
> 
> Ummm, 4GB maybe? ;)
> 
> Rik

Ahh, it's totally obvious.  1 GB option = 890 MB, 4 GB option = 4GB.  Can I assume a linear relation and get 66.2 MB when I select the 64 MB option?

;)

-Jeff

-- 
Jeff Golds
jgolds@resilience.com
