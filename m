Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264316AbUEIJC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264316AbUEIJC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 05:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264322AbUEIJC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 05:02:56 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:23197 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264316AbUEIJCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 05:02:53 -0400
From: "Peter J. Braam" <braam@clusterfs.com>
To: <akpm@osdl.org>
Cc: <intermezzo-devel@lists.sourceforge.net>, <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>, "'Anton Blanchard'" <anton@samba.org>
Subject: RE: 9/10 intermezzos prefer eating memory
Date: Sun, 9 May 2004 17:01:54 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcQwHr/n2dBTZBe2RBqO7890Zt+jxwFgtqrQ
In-Reply-To: <1083486146.3842.1.camel@laptop.fenrus.com>
Message-Id: <20040509090249.A78D03100BD@moraine.clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi Andrew, 

I would just like to say that I have no difficulties with intermezzo being
rm -rf'd.  There are probably only a handful of users.   

In the past 4 years nobody has supported InterMezzo sufficiently for it to
become successful. I have been fortunate to get really good support for the
Lustre project.  So I have focussed on that.  Lustre 1.X has become really
solid.

The disconnected operation, caching and mirroring functionality of
InterMezzo will become available in Lustre as a new feature in version 2.  

So I see no point in keeping InterMezzo if it is a nuisance.  

I am also entirely happy to ask my one part time InterMezzo programmer to do
a better job of repeatedly sending pathes until they are in.

Please guide me along.  Thanks!

- Peter -


> -----Original Message-----
> From: intermezzo-devel-admin@lists.sourceforge.net 
> [mailto:intermezzo-devel-admin@lists.sourceforge.net] On 
> Behalf Of Arjan van de Ven
> Sent: Sunday, May 02, 2004 4:22 PM
> To: Anton Blanchard
> Cc: akpm@osdl.org; intermezzo-devel@lists.sourceforge.net; 
> linux-kernel@vger.kernel.org
> Subject: Re: 9/10 intermezzos prefer eating memory
> 
> On Sun, 2004-05-02 at 10:00, Anton Blanchard wrote:
> > Hi,
> > 
> > Im sure the 4kB stack brigade wont be too happy about this:
> 
> I thought intermezzo would have been rm -rf'd by now...
> 

