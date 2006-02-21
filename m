Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbWBUSxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWBUSxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWBUSxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:53:42 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:8843 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932668AbWBUSxl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:53:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IWNx6LEk1tXzjAW3y2xznioFDT+nt4b7c1w6sqcJcVWx4hnJyYfMJTQRt6b59sthq2O3xnAQHAiK3jshj8urSlP4YLJzHtA6sb3htnp73dYSFJZRgg6MlT2rdjJRGeYY8Fm3sO4lZk9K5sUznNamEKMBabEK0BL7axhMC0npITo=
Message-ID: <6bffcb0e0602211053y143d9049g@mail.gmail.com>
Date: Tue, 21 Feb 2006 19:53:39 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.15-rt17
Cc: linux-kernel@vger.kernel.org, "Esben Nielsen" <simlo@phys.au.dk>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Steven Rostedt" <rostedt@goodmis.org>
In-Reply-To: <6bffcb0e0602210916n3ddbd50i@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060221155548.GA30146@elte.hu>
	 <6bffcb0e0602210916n3ddbd50i@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
[snip]
> Here is config http://www.stardust.webpages.pl/files/rt/2.6.15-rt17/rt-config
> Here is dmesg http://www.stardust.webpages.pl/files/rt/2.6.15-rt17/rt-dmesg

Here is updated config
http://www.stardust.webpages.pl/files/rt/2.6.15-rt17/rt-config2
Here is updated dmesg
http://www.stardust.webpages.pl/files/rt/2.6.15-rt17/rt-dmesg2

BTW. thanks for fixing CONFIG_DEBUG_HIGHMEM=y

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
