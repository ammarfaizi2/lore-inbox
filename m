Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVAXJzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVAXJzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 04:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVAXJzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 04:55:50 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:42206 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261419AbVAXJzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 04:55:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=emBJKBDZ9zTk6wjCIVRVFZaTV0PjlxiPnB/ARZyZ7yK3y/kKqrpFbGSa5vGoPdkTOJcea/do2yncSl3tUV6+JAsOfcPTUnPUJcQynzUL8pOCbwvxVz5Mm4Kf65ozJTarh5pd7KgypICVW+hoLgkGJZma5+x3/2p1rPWTcPmX6ak=
Message-ID: <4d8e3fd3050124015528615310@mail.gmail.com>
Date: Mon, 24 Jan 2005 10:55:45 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20050124085902.GA8059@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	 <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	 <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	 <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 09:59:02 +0100, Ingo Molnar <mingo@elte.hu> wrote:
[...]
> - CKRM is another possibility, and has nonzero costs as well, but solves
>  a wider range of problems.

BTW, do you know what's the status of CKRM ?
If I'm not wrong it is already widely used, is there any plan to push
it to mainstream ?

-- 
Paolo <paolo dot ciarrocchi at gmail dot com>
