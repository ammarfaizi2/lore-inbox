Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264848AbTF0VtV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 17:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbTF0VtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 17:49:20 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:13227 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264848AbTF0VtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 17:49:16 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 27 Jun 2003 15:02:00 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "David S. Miller" <davem@redhat.com>
cc: mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
In-Reply-To: <20030627.143738.41641928.davem@redhat.com>
Message-ID: <Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com>
References: <20030626.224739.88478624.davem@redhat.com> <21740000.1056724453@[10.10.2.4]>
 <Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com>
 <20030627.143738.41641928.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jun 2003, David S. Miller wrote:

> No, this is the _BAD_ part, shit accumulates equally with
> useful reports.
>
> Useful reports in non-bugtracking system environments get
> retransmitted and eventually looked at.

David, your method is the dream of every software developer. Having Q/A
repeatedly pushing the same issue. Having a track is good and flagging a
report as not-a-bug or need-more-info takes almost the same time (if the
system is sanely designed) it takes you to flag your message a shit. In
this way though you do not lose things meaningful that you overlooked at
first sight. And this comes from someone that wanted to quit his job when
they forced for the first time to use a tracking system ;)



- Davide

