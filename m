Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272298AbRIEToh>; Wed, 5 Sep 2001 15:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272291AbRIEToR>; Wed, 5 Sep 2001 15:44:17 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:9988 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S272289AbRIEToG>;
	Wed, 5 Sep 2001 15:44:06 -0400
Date: Wed, 5 Sep 2001 15:44:25 -0400 (EDT)
From: Olivier Crete <Tester@videotron.ca>
X-X-Sender: <Tester@TesterTop.PolyDom>
To: Alan Garrison <alan@alangarrison.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Laptop problems with Yenta... Workaround...
In-Reply-To: <Pine.LNX.4.33.0109051432050.1646-100000@TesterTop.PolyDom>
Message-ID: <Pine.LNX.4.33.0109051537430.931-100000@TesterTop.PolyDom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I found a solution... I can't reproduce the problem when I use the
independant pcmcia_cs package instead of the drivers that are in the main
kernel tree...  So the problem is somewhere in the (or triggered by
yenta)...

The pcmcia_cs package is at: http://pcmcia-cs.sourceforge.net/

But, that does not fix yenta....

The

-- 
Olivier Crete
Tester
tester@videotron.ca
oliviercrete@videotron.ca

Those who do not understand Unix are condemned to reinvent it, poorly. -- Henry Spencer

