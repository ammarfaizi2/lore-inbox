Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132501AbRC1DWP>; Tue, 27 Mar 2001 22:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132524AbRC1DWF>; Tue, 27 Mar 2001 22:22:05 -0500
Received: from 3-123.cwb-adsl.telepar.net.br ([200.193.162.123]:530 "EHLO imladris.rielhome.conectiva") by vger.kernel.org with ESMTP id <S132510AbRC1DV6>; Tue, 27 Mar 2001 22:21:58 -0500
Date: Wed, 28 Mar 2001 00:21:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Doug Ledford <dledford@redhat.com>
cc: james <jdickens@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Ideas for the oom problem
In-Reply-To: <3AC13ADD.1341E7AE@redhat.com>
Message-ID: <Pine.LNX.4.21.0103280020110.8261-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Doug Ledford wrote:

> I've been using our internal tree for my testing, and I'm reluctant to
> let my experiences there cause me to draw conclusions about other
> trees.  So, will you please tell me which version of the kernel you
> think has a vm that only triggers the oom killer in emergency
> situations so I can test it here to see if you are right?

Detecting WHEN we're OOM is quite unrelated from chosing WHAT
to do when we're OOM.

There is currently no kernel that I'm aware of which does the
OOM kill at the "exact right" moment.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

