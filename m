Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUJJAyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUJJAyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUJJAx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:53:59 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44742 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267971AbUJJAxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:53:50 -0400
Date: Sat, 9 Oct 2004 17:50:53 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: frankeh@watson.ibm.com, ricklind@us.ibm.com, mbligh@aracnet.com,
       Simon.Derr@bull.net, pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] Re: [PATCH] cpusets - big numa cpu and memory
 placement
Message-Id: <20041009175053.45b73125.pj@sgi.com>
In-Reply-To: <1097283081.6470.138.camel@arrakis>
References: <20041007015107.53d191d4.pj@sgi.com>
	<200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	<20041007072842.2bafc320.pj@sgi.com>
	<4165A31E.4070905@watson.ibm.com>
	<20041008061426.6a84748c.pj@sgi.com>
	<1097283081.6470.138.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew, responding to Paul:
> > But I haven't figured out exactly what will be lost.  And I lack the
> > mastery of CKRM that would enable me to engage in a constructive dialog
> > on the various tradeoffs that come into play here.
> 
> I hope that *nothing* will be lost.  We (I) aim to still offer
> users/admins named groupings of CPUs and memory.  They may not be called
> cpusets, in favor of names like classes or domains, but they will
> *still* be named groupings of CPUs and memory.  I further aim to not
> change your API significantly. 

This might work.

I've no earthly idea yet how it might work.  But I take you at your word
that there's potential here worth pursuing.

I've gotten behind on my email the last three days - sleeping off a
cold.  Do you have any suggestions for readings, or further explanations
you can provide, that might help me better understand how you intend to
accomplish this minor miracle?  Perhaps there is something in one of the
messages that I haven't digested yet.  I see your work-in-progress patch
of Wed, 06 Oct 2004 17:51:07 is one of the messages still in my input
queue.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
