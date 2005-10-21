Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVJUNrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVJUNrv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVJUNrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:47:51 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:62342 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964951AbVJUNru convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:47:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tH/w2+ARDe5x+juSnwulhwE6p2lH1q/ilqcsHkOK+4vprplaPLb8tUv90+D/NFETothXEXUG4ydGGxQxHu1JnDP74D440dBlBREPnKgEfWSIlfrd1vPpioewNnLuZcIwOZ3dk295NLe7cvALhpU4zNZcV5opMhCVYOwWjDn3PRo=
Message-ID: <5bdc1c8b0510210647v59bbc556odc17b58c361e5a77@mail.gmail.com>
Date: Fri, 21 Oct 2005 06:47:49 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc5-rt1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <5bdc1c8b0510201739u6b3a5158x5773b6b418d95e32@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <200510210033.49652.lkml@oxley.org>
	 <5bdc1c8b0510201739u6b3a5158x5773b6b418d95e32@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/05, Mark Knecht <markknecht@gmail.com> wrote:
<SNIP>
>
> 2.6.14-rc5-rt1 is up and running for me. No errors or problems in
> dmesg. Jack is running at 64/2 (<3mS) with no problems so far.
>
<SNIP>

Unfortunately I got a large rash of xruns late in the evening. First
problem like that in days.

I'll turn on latency tracing and see if I can catch anything today.
There still appears to be somethign going on here.

- Mark
