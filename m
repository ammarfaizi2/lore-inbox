Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268691AbTBZJ0J>; Wed, 26 Feb 2003 04:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268692AbTBZJ0J>; Wed, 26 Feb 2003 04:26:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14889 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268691AbTBZJ0J>; Wed, 26 Feb 2003 04:26:09 -0500
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Server shipments [was Re: Minutes from Feb 21 LSE Call]
References: <E18nu68-0004Ty-00@calista.inka.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Feb 2003 02:36:13 -0700
In-Reply-To: <E18nu68-0004Ty-00@calista.inka.de>
Message-ID: <m165r7mliq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net> writes:

> In article <03022522230400.04587@tabby> you wrote:
> > The output is fed to memory on every clock tick. (most Cray processors have 4
> 
> > memory busses for each processor - two for input data, one for output data 
> > and one for the instruction stream
> 
> The fastest Cray on top500.org is T3E1200 on rank _22_, the fastest IBM is
> ranked _2_ with a Power3 PRocessor. There are 13 IBM systems before the
> first (fastest) Cray system. Of course those GFlops are measured for
> parallel problems, but there are a lot out there.

And it is especially interesting when you note that among 2-5 the
ratings are so close a strong breeze can cause an upset.  And that #5
is composed of dual CPU P4 Xeon nodes....

Eric


