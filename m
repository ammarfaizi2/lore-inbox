Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSGMNli>; Sat, 13 Jul 2002 09:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSGMNlh>; Sat, 13 Jul 2002 09:41:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:30446 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313537AbSGMNle>; Sat, 13 Jul 2002 09:41:34 -0400
Subject: Re: Future of Kernel tree 2.0 ............
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: c0330 <c0330@yingwa.edu.hk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E17TUXf-0000Ow-00@ited.yingwa.edu.hk>
References: <E17TUXf-0000Ow-00@ited.yingwa.edu.hk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 15:53:26 +0100
Message-Id: <1026572006.9956.106.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 22:35, c0330 wrote:
>   Will kernel tree 2.0 stop developing and regard historical after the release 
> of 2.6?  I think we would put our focus on much more newer kernel. And I found 
> this may confuse the newbies, because they don't know much about versioning in 
> Kernel.

Why should you care ? 2.0 can continue to slowly and cautiously get
critical bug fixes between now and the end of time providing someone
cares enough to do the work. There are plenty of 2.0 boxes employed as
routers, print servers, intranet dialins etc which will probably only
become 2.4 boxes when the hardware is taken out of service.

I can't speak for David Weinehall's experience, and I know he does a lot
more chasing down of bug reports than I bother to with 2.2 but in my
experience maintaining a very stable kernel tree like 2.2 is nowdays is
not a massive workload. It primarily consists of sending emails out
which say "no"

