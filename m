Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWCEVus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWCEVus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWCEVus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:50:48 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:32422 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751846AbWCEVus convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:50:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZIjFbptYOABBQivIukiPPn9qoSJBW6NF34bA+U6AhXkjdrI+TWKw6vDV0BmcNWGqJ1Ai82TFRBh57YWPzlm+IJbpSAqoA1VPnHZjZOBhvhGFxxVODtM1in4XWQAg2CvQG1Fd9SxAk0pCS0A7RvzuaOjMx3p35wBf2UYv9ph+ub4=
Message-ID: <35fb2e590603051350o27a00274r4566e65e3fb99721@mail.gmail.com>
Date: Sun, 5 Mar 2006 21:50:47 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [OT] inotify hack for locate
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490603051342r64f1dd65qecf72a8016a0d520@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
	 <9a8748490603051342r64f1dd65qecf72a8016a0d520@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:

> On 3/5/06, Jon Masters <jonmasters@gmail.com> wrote:

> > I'm fed up with those finds running whenever I power on.

> You run updatedb at boot time?

No, but said box will catch up cron jobs on boot.

> Why not run it from cron at night like most people do?

That's not the point. It usually does. I'm interested to know if
anyone has written a daemon that can sit and just do this
synchronously on my desktop - then not only do I /not/ have to run
updatedb every day but I can also have a locate that is always up to
the minute.

Jon.
