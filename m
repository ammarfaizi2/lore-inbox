Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbTHSV7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTHSV7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:59:01 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:47506 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261465AbTHSV6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:58:49 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 19 Aug 2003 23:58:46 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: alan@lxorguk.ukuu.org.uk, andrea@suse.de, green@namesys.com,
       marcelo@conectiva.com.br, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030819235846.44708aef.skraw@ithnet.com>
In-Reply-To: <20030819180028.GB19465@matchmail.com>
References: <20030813125509.360c58fb.skraw@ithnet.com>
	<Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
	<20030813145940.GC26998@namesys.com>
	<20030813171224.2a13b97f.skraw@ithnet.com>
	<20030813153009.GA27209@namesys.com>
	<20030819180028.GB19465@matchmail.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 11:00:28 -0700
Mike Fedyk <mfedyk@matchmail.com> wrote:

> Are you doing a lot of directory operations, or is it mostly just large
> amounts of data transfering over NFS?

In fact merely no directory operations take place. Large data movement is the
primary test.

Regards,
Stephan
