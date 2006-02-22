Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWBVNrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWBVNrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWBVNrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:47:08 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:40898 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751283AbWBVNrH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:47:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lgRHkzyal+QSTWvDHl3GLTSwlh1Ey3kECxQxalKK6KzRi5MzCXGLH13dB6kM+UcPxJn3m9II3NsEsETbIW3gfuH+Uk7Ljk/EIr0GtQbsVLPMp4xkYRza+uamr/cwZKoN9MLyunDvMivFHzMxY7zqGkxAjJctg8J9J+ltiTCWSoU=
Message-ID: <6bffcb0e0602220547o732ab502q@mail.gmail.com>
Date: Wed, 22 Feb 2006 14:47:06 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: 2.6.15-rt17
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Esben Nielsen" <simlo@phys.au.dk>,
       "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <Pine.LNX.4.58.0602220715460.4164@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060221155548.GA30146@elte.hu>
	 <6bffcb0e0602210916n3ddbd50i@mail.gmail.com>
	 <Pine.LNX.4.58.0602220715460.4164@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/02/06, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Ingo,
>
> Maybe the following patch is needed, so that people know that this is not
> a bug.
>
> -- Steve

It will be a very useful piece of information for kernel testers (aka.
not hackers ;).

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
