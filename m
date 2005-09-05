Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVIEUhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVIEUhG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVIEUhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:37:06 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:62426 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932090AbVIEUhF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:37:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Con/hYuncmN+pjgAeMCKTDdW4ZPwRsi5L6ie8aASxrhOjBlgM4QSYFJK1gwneXp8ORVWMfOn1dVzs0c+QMSC1KxQ360BA+mN0tZ9UJ44azSg76IGXlVN5Mlo74+fVRawJYxMRDznXfw7nRcMf0+2xaH4PaHlg1q6B05uuL7Y/Kc=
Message-ID: <9a874849050905133650caa09e@mail.gmail.com>
Date: Mon, 5 Sep 2005 22:36:57 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] Omnikey Cardman 4000 driver
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20050906013545.GB16056@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050906013545.GB16056@rama.de.gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, Harald Welte <laforge@gnumonks.org> wrote:
> Hi!
> 
[snip]
> 
> Please consider mergin mainline, thanks.
> 
[snip]

Wouldn't it be better to first merge it in -mm and get some wider
testing before pushing for mainline?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
