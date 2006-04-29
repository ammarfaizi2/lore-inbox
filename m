Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWD2Ol1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWD2Ol1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 10:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWD2Ol1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 10:41:27 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:17585 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750735AbWD2Ol0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 10:41:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=cL0kUxzKFXr7W6fBW2NY8ZmGEU7Zj52ZaLi8lGvZVS/faQ1BPkYP0gTNjMtI2dRKPfMXhWRJmG28lksbWvDL/hSoAzj8jAn4LVVCkBLt6KwXhn2N7AfE8nC3cCPzTTYNXjKdlHhl5McNp0Wd4czUHwU6WltiSyTOeQBr9P+/QI0=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 0/6] UML - Small patches for 2.6.17
Date: Sat, 29 Apr 2006 16:41:18 +0200
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <200604281601.k3SG11MJ007510@ccure.user-mode-linux.org> <20060428165534.6067f5aa.akpm@osdl.org>
In-Reply-To: <20060428165534.6067f5aa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604291641.19864.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 April 2006 01:55, Andrew Morton wrote:
> Jeff Dike <jdike@addtoit.com> wrote:
> > These patches are 2.6.17 material.
>
> "remove NULL checks and add some CodingStyle" isn't.

Being restrictive is ok, but keeping patches in queues for longer than needed 
creates more headaches than it solves, in my experience.

> Unless one considers 
> UML coding style to be a bug, which is an attractive idea ;)

Well, we're slowly working on that... very slowly... I've thought multiple 
times to at least run Lindent on arch/um but I've not spoken up because of 
all the conflicts we (me and Jeff) would get with patches in our queues.

However, there are occasions in which we get conflicts anyway for other 
reorganization, and in that case Lindent would be useful. Ok Jeff? I'm 
speaking for instance about moving to os-Linux and such.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
