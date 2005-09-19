Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVISQAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVISQAb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 12:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVISQAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 12:00:31 -0400
Received: from [212.76.80.60] ([212.76.80.60]:15365 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932476AbVISQA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 12:00:29 -0400
From: Al Boldi <a1426z@gawab.com>
To: coywolf@gmail.com
Subject: Re: Fork capture
Date: Mon, 19 Sep 2005 18:01:47 +0300
User-Agent: KMail/1.5
Cc: linux-assembly@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-smp@vger.kernel.org
References: <200509181748.40029.a1426z@gawab.com> <2cd57c9005091823551e49bc23@mail.gmail.com>
In-Reply-To: <2cd57c9005091823551e49bc23@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509191801.47546.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> On 9/18/05, Al Boldi <a1426z@gawab.com> wrote:
> > Is there a way to capture a process-fork?
> >
> > Something like:
> > process/kModule A monitors procs for forking, captures it and manages
> > further processing.
>
> Look at the fork_connector patch.

Nice, but how could this be used to _manage_ further process-execution?

Also, would a user-space solution be possible?

Thanks!

--
Al

