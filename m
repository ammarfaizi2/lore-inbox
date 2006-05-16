Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWEPXKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWEPXKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 19:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWEPXKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 19:10:50 -0400
Received: from wx-out-0102.google.com ([66.249.82.207]:41785 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932204AbWEPXKt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 19:10:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JunHeuIY0loQXOQWx5AdT5OaYcC9xjLKrNATSXgM3c2eoM+XK/V9BPK9pbMPXVm010/72GDDy0SwSiiz+MnVdH5N2NUjehx7IfF44bWOJpyMwEN5z4iXRNED4UR2TS32VGGbYwR9nIB44LEDdexV9zyvGY4qeBP9AT3heeAP3Cg=
Message-ID: <6f6293f10605161610p28358fb6p35c85a30c9a2c1f4@mail.gmail.com>
Date: Wed, 17 May 2006 01:10:48 +0200
From: "Felipe Alfaro Solana" <felipe.alfaro@gmail.com>
To: "linux cbon" <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060516214148.14432.qmail@web26611.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060516214148.14432.qmail@web26611.mail.ukl.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> X Window System is old

Yep, but works pretty good. It allows for very smart and useful
things, like separating execution from presentation.

> not optimized

I wouldn't say so.

> slow

Slow? Have you ever seen Xgl?

> not secure (uses root much), accesses the video hardware
> directly (thats the kernel's job !)

> it cannot do VNC, etc.

What? You must be kidding. There's an X.org module which adds support
for VNC. It's built-in an I haved used it in the past to remotely
control some of my machines.
