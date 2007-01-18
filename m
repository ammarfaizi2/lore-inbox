Return-Path: <linux-kernel-owner+w=401wt.eu-S932148AbXARJok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbXARJok (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 04:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbXARJoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 04:44:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:36515 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137AbXARJoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 04:44:38 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=EgKwT3NzXSe8rJKO4v/K7Lq0YEu3s2hJavSfknwFouT55gj+igU1p1Zln1852I3srq5eQ7lWNZFuzsjU1nS2m6VYHeuYmXVN8Veq3Bjhfx+0mlVAYRP6amCym+Fw2TeC3T6bJW/R1K4J7OWNFS1y0UOjypuK+k+YSQb4drW0yvA=
Date: Thu, 18 Jan 2007 11:44:11 +0200
To: Rajat Jain <rajat.noida.india@gmail.com>
Cc: Daniel Rodrick <daniel.rodrick@gmail.com>,
       kernelnewbies <kernelnewbies@nl.linux.org>,
       Linux Newbie <linux-newbie@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: after effects of a kernel API change
Message-ID: <20070118094411.GB29695@Ahmed>
References: <292693080701172015n736a269fl6945ba4fe19d8174@mail.gmail.com> <20070118051026.GA29695@Ahmed> <b115cb5f0701172135k411dca56u92101a929799548a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b115cb5f0701172135k411dca56u92101a929799548a@mail.gmail.com>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 11:05:53AM +0530, Rajat Jain wrote:
> >>
> >> Is there any way volunteers like me can help in this exercise?
> >
> >See the /APIchanges in the Kernel Janitors TODO list
> >http://kernelnewbies.org/KernelJanitors/Todo
> >
> [...]
> 1) How do I make sure if some one is NOT working on any of the
> mentioned bullet points? Who coordinates? On what mailing list?

Check latest trees to make sure the work is not duplicated. espicially 
trees like -mm and subsystem ones.

> 2) Do any patches for the above Todo list have the chances of getting
> merged into the mainstream kernel? Who approves? I suppose the
> respective maintainer of the driver / subsystem getting affected?

I advise lurking (following/reading) the list for at least 2 or 3 weeks and 
you'll automatically understand how the "system" works. Also check:

$KERNEL_TREE/Documentation/HOWTO
$KERNEL_TREE/Documentation/SubmittingPatches
$KERNEL_TREE/Documentation/CodingStyle

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
