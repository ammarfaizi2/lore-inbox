Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbREWJZr>; Wed, 23 May 2001 05:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263028AbREWJZ3>; Wed, 23 May 2001 05:25:29 -0400
Received: from ns.tulsyan.com ([216.5.0.102]:6669 "EHLO tuls1.tulsyan.com")
	by vger.kernel.org with ESMTP id <S263026AbREWJZJ>;
	Wed, 23 May 2001 05:25:09 -0400
From: hanishkvc@fedtec.com
Date: Wed, 23 May 2001 14:53:43 +0530 (IST)
Reply-To: hanishkvc@fedtec.com
To: Khader Syed <sid.carter@techie.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Changing the Number of processes/tasks
In-Reply-To: <20010523080152.19119.qmail@mail.com>
Message-ID: <Pine.LNX.4.21.0105231451550.13213-100000@hanishkvc.fedtec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Khader,

If I am not wrong there is no limit on Number of processes based on the
process table size or so as It should be dynamicaly growing as required
in 2.4. 

On Wed, 23 May 2001, Khader Syed wrote:

> Hi Folks,
> How can I change the Number of processes that can be run on the 2.4 kernel ?
> Is there a way to change that ? I would be glad if someone can direct me in this regards. In kernel 2.2.x, we could modify tasks.h to accompliish the task. How do we
> go about doing it in the 2.4 kernel ?
> Sorry if this question has been answered before, I could not find it in the archives.
> Thanks in Advance
> Regards
>            Carter
> 

