Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275901AbTHOK2w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275902AbTHOK2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:28:52 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:18406 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S275901AbTHOK2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:28:30 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Fri, 15 Aug 2003 12:28:27 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Chris Mason <mason@suse.com>
Cc: marcelo@conectiva.com.br, green@namesys.com, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030815122827.067bd429.skraw@ithnet.com>
In-Reply-To: <1060913337.1493.29.camel@tiny.suse.com>
References: <20030814084518.GA5454@namesys.com>
	<Pine.LNX.4.44.0308141425460.3360-100000@localhost.localdomain>
	<20030814194226.2346dc14.skraw@ithnet.com>
	<1060913337.1493.29.camel@tiny.suse.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Aug 2003 22:08:58 -0400
Chris Mason <mason@suse.com> wrote:

> Run 4 or so fsx-linux programs (each to its own file) and use usemem to
> put your box into swap.  That should hit it pretty quickly, and any
> errors from fsx indicate problems.

Question: how do I make fsx-linux use big filesizes (GB range) ?

Regards,
Stephan
