Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVCGLWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVCGLWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 06:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVCGLV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 06:21:59 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:5674 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261210AbVCGLVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 06:21:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=T6QnUVfMdGhtQitAHZkwAA07q7bAFjG3O17AROQIEbE74+fgvnAQSWgINb7HQFZklnatJ+8fDbm5UtbtEL5Nm7s6KLbnd2bPVyXw0ZIWb+t3CiTwWpyVrm7O7zca0CnbylHKDbEOzm5eHb64ijzrNDC5HgUdFVMj/vujZtthmvQ=
Message-ID: <65258a58050307032152fa5e7d@mail.gmail.com>
Date: Mon, 7 Mar 2005 12:21:47 +0100
From: Vincent Vanackere <vincent.vanackere@gmail.com>
Reply-To: Vincent Vanackere <vincent.vanackere@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-ck1 (cfq-timeslice)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050304140750.757e9f4a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200503030030.29722.kernel@kolivas.org>
	 <65258a58050304064710b403d7@mail.gmail.com>
	 <20050304140750.757e9f4a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005 14:07:50 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Vincent Vanackere <vincent.vanackere@gmail.com> wrote:
> >
> > (I can't live without reiser4 any more...).
> 
> Tell us more?
> 

I've been storing all my important data (including music ;-) ) on
reiser4 since a few months... Others may disagree, but for me and my
data it is definitely safer than
reiser3-before-ordered-data-mode-was-integrated.
With time and use, I'm starting to really trust it : absolutely no
data-loss or corruption experienced in spite of a few power-outage and
other unrelated (bad kernels) crashes (*)...

Vincent

(*) as seen by the very few reiser4 bugs reported on the reiserfs
mailing-list these days, I'd say that there are either almost no
reiser4 users left, or that users are indeed encountering very few
problems with it...
