Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTLaK53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTLaK52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:57:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:58498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264256AbTLaK50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:57:26 -0500
Date: Wed, 31 Dec 2003 02:57:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, davem@redhat.com
Subject: Re: 2.6.0-rc1-mm1
Message-Id: <20031231025752.754fd926.akpm@osdl.org>
In-Reply-To: <20031231104947.GC16860@louise.pinerecords.com>
References: <20031231004725.535a89e4.akpm@osdl.org>
	<20031231101907.GB16860@louise.pinerecords.com>
	<20031231024855.0aca5e52.akpm@osdl.org>
	<20031231104947.GC16860@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> wrote:
>
> What I did was:

Well that just reverts the recent change back to the way it was.  I assume
that change was made for a reason.  But with such a lame changelog I am not
able to say what it was.   No doubt Dave will hunt down the perps ;)

