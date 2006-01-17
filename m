Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWAQVcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWAQVcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWAQVcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:32:14 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:3089 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932430AbWAQVcN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:32:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BF7CpzwYs0m3qEq4HC8sArJs7lU+/1Hd4KBFh0mLgcjOp5IVCS5vsPWMikiOvVB80tZO93x1xs8KN45DT6+BC+gp1xKL/SDJZdv74MP1Sss/7LXmQ1Fmueen/5z5x13qxSECXgnfJ3WTZApGnG4sqoc4to4LpXhvsFiz4U4VS5k=
Message-ID: <728201270601171332v6c95df17u167d15212dde66c4@mail.gmail.com>
Date: Tue, 17 Jan 2006 15:32:11 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: X killed
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Willy Tarreau <willy@w.ods.org>,
       linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <43CD599B.8050002@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43CA883B.2020504@superbug.demon.co.uk>
	 <20060115192711.GO7142@w.ods.org>
	 <43CCE5C8.7030605@superbug.demon.co.uk>
	 <Pine.LNX.4.61.0601172111070.11929@yvahk01.tjqt.qr>
	 <43CD599B.8050002@superbug.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/06, James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> Jan Engelhardt wrote:
> >>My point is that there is no way to tell what kills me. No messages in
> >>syslog...nothing. Surely the OOM killer would send a message to ksyslog, or at
> >>least dmesg?

You may try using strace . It may throw some light on the cause of the problem.

Regards
Ram gupta
