Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbTAQJVW>; Fri, 17 Jan 2003 04:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTAQJVW>; Fri, 17 Jan 2003 04:21:22 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:59388 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267446AbTAQJVV>; Fri, 17 Jan 2003 04:21:21 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030117041739.GA15753@work.bitmover.com> 
References: <20030117041739.GA15753@work.bitmover.com>  <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au> <Pine.LNX.4.44.0301162211410.19302-100000@chaos.physics.uiowa.edu> 
To: Larry McVoy <lm@bitmover.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Carl Gherardi <C.Gherardi@curtin.edu.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Jan 2003 09:30:08 +0000
Message-ID: <2326.1042795808@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lm@bitmover.com said:
> A little know option which makes things go faster is 
> 	bk -r get -qS
> which gets only those files not already gotten.  Linus has asked why
> this  isn't the default and the only reason I can give him is that it
> is an interface change and we'll do it in bk 4.0.  It's the right
> answer.

Isn't there some way to tell BK to extract the files _while_ it's pulling 
the deltas. You know; while it's all right there in the cache?

--
dwmw2


