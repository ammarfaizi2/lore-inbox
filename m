Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWCFNMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWCFNMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWCFNMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:12:37 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:6285 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932182AbWCFNMg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:12:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S6vGWX9X5EvazWdMKMmO8EMEqDz/IBssm4SED2++ETfU4eW6ZkkBfZHaEqLqtqoN4Bn+VM7Rmx6G08MYiw9MQ6zGDJg5phMj8QHulBW/fF3aXgPDING+7paWb1A8e5/hCkFAh2wg6d8gKMSQqKcDAZeCDcRWr3rY80altNQ2zYo=
Message-ID: <35fb2e590603060512r4175f080w2d49a20612d38fcd@mail.gmail.com>
Date: Mon, 6 Mar 2006 13:12:35 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [OT] inotify hack for locate
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1141631385.4084.0.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
	 <1141631385.4084.0.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Arjan van de Ven <arjan@infradead.org> wrote:

> On Sun, 2006-03-05 at 21:36 +0000, Jon Masters wrote:

> > I'm fed up with those finds running whenever I power on. Has anyone
> > written an equivalent of the Microsoft indexing service to update
> > locate's database?

> there is both rlocate and mlocate to replace whatever variant of locate
> you are using.

Interesting.

> But this is obviously offtopic for lkml

Not entirely - because I'm asking about VFS functionality. I'm going
to look at the rlocate kernel module with a view to doing something
generic that communicates over netlink like I want. Thanks.

Jon.
