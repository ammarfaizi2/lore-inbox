Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbTCLSLU>; Wed, 12 Mar 2003 13:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbTCLSLT>; Wed, 12 Mar 2003 13:11:19 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:57771 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261819AbTCLSLD>; Wed, 12 Mar 2003 13:11:03 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 12 Mar 2003 10:30:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Waitz <tali@admingilde.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <20030312180819.GB27366@admingilde.org>
Message-ID: <Pine.LNX.4.50.0303121027560.991-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <XFMail.20030311171056.pochini@shiny.it> <20030312180819.GB27366@admingilde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003, Martin Waitz wrote:

> On Tue, Mar 11, 2003 at 05:10:56PM +0100, Giuliano Pochini wrote:
> > If ET il faster than LT, tell people to stop whining and to learn
> > the API. Otherwise choose LT, mainly because of 2), but also
> > because ET API is more subtle bug prone.
>
> in some situations, ET simply has wrong semantics.

IMO ET has perfectly nice semantics. The fact that ppl fail to understand
it does not make it automatically wrong. If things not understood would
have been flagged as wrong, we would be still living in caves.



- Davide

