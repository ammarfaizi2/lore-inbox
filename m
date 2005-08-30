Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVH3MG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVH3MG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVH3MG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:06:56 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:60738 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751399AbVH3MG4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:06:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l2jRwYYgorc2XyTUCo0xzbOXhzp9GTPVUeDyWzTQMIbU44qav7E2j/Go4/pQ2vyyHMnlVfI2tIo3Q+Ropc5iPgn5i9sDd8OdfW2yEeaMcrtVtwWGh6C896oMib8SLD2p2DsqaNmtBeN/GNBbHsTs+aQcDcWfHUJGzzYm4h2Mh58=
Message-ID: <9a87484905083005064cf4e6d0@mail.gmail.com>
Date: Tue, 30 Aug 2005 14:06:51 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Chase Venters <chase.venters@clientec.com>
Subject: Re: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508292303.52735.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508292303.52735.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Chase Venters <chase.venters@clientec.com> wrote:
> Greetings kind hackers...
>         I recently switched to 2.6.13 on my desktop. I noticed that the second
> "CPU" (is there a better term to use in this HyperThreading scenario?) that
> used to be listed in /proc/cpuinfo is no longer present. Browsing over the
[snip]

CONFIG_MPENTIUM4, CONFIG_SMP and CONFIG_SCHED_SMT enabled?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
