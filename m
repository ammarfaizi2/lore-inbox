Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132212AbRC1BJ0>; Tue, 27 Mar 2001 20:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132218AbRC1BJQ>; Tue, 27 Mar 2001 20:09:16 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:4376 "EHLO devserv.devel.redhat.com") by vger.kernel.org with ESMTP id <S132212AbRC1BJJ>; Tue, 27 Mar 2001 20:09:09 -0500
Message-ID: <3AC13ADD.1341E7AE@redhat.com>
Date: Tue, 27 Mar 2001 20:14:05 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: james <jdickens@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Ideas for the oom problem
References: <Pine.LNX.4.21.0103272151580.8261-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 27 Mar 2001, james wrote:
> 
> > Here are my ideas on how too deal with the oom situation,
> 
> > I propose a three prong approach too this problem
> 
> Isn't that a bit much for an emergency situation that never
> even occurs on most systems ?

I've been using our internal tree for my testing, and I'm reluctant to let my
experiences there cause me to draw conclusions about other trees.  So, will
you please tell me which version of the kernel you think has a vm that only
triggers the oom killer in emergency situations so I can test it here to see
if you are right?

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
