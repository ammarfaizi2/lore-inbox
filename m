Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbTLIP7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266082AbTLIP7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:59:35 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:41661 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S266081AbTLIP7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:59:34 -0500
X-Sender-Authentication: net64
Date: Tue, 9 Dec 2003 16:59:26 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Vladimir Saveliev <vs@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.23] kernel BUG at page_alloc.c:235!
Message-Id: <20031209165926.18a5c3fa.skraw@ithnet.com>
In-Reply-To: <200312081939.07390.vs@namesys.com>
References: <200312081939.07390.vs@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003 19:39:07 +0300
Vladimir Saveliev <vs@namesys.com> wrote:

> Hi
> 
> A program which reads spontaneously 4k blocks from a device (sda1) causes the following quite fast.

> [...]
> Ksymoops provides
> 
> vs@tribesman:/tmp/> ksymoops -m System.map file2 -V -O -K
> ksymoops 2.4.9 on i686 2.4.21-144-default.  Options used

What kind of a kernel is this? Are you sure you are running 2.4.23 ?


Regards,
Stephan
