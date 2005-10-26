Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVJZKUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVJZKUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 06:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVJZKUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 06:20:46 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:65238 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751339AbVJZKUp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 06:20:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N8yzVgH0TW1sdNxS2YstoVMip/DBmk0fOJpTRlXuDdy2EAKEAGQgMlLg5dR6WIJsByUzAea1a7cV7YgiCRqpNCh9o1OfCbAtnIsCgguH0+OrnTkn1Pmm/onFK2NhxIIt8HhWpyo+4bEmt5P2XFqm81hQyWZCryJ9JAbw1rqXKMo=
Message-ID: <21d7e9970510260320w5d9e9e6fvcfdf16f29366a03f@mail.gmail.com>
Date: Wed, 26 Oct 2005 20:20:44 +1000
From: Dave Airlie <airlied@gmail.com>
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [2.6.14-rc? on x86-64] Total machine freeze
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051022124306.36d13c39@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051022124306.36d13c39@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> 2.6.14-rc[45] works fine here, usually. But sometimes (~2 times in a
> week) I get an hard-freeze:
>         Sys-RQ doesn't work
>         machine doesn't reply to ping / ssh
>         nothing in the logs
>
> Seems like it loops somewhere with interrupt disabled... but I don't
> know.
>
Does it get into X and crash?, did it do it with 2.6.13?

Do you have any "ricer" X options turned on like AGPFastWrite..

Dave.
