Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbTHZSvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbTHZSvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:51:39 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:10322 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262880AbTHZSvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:51:36 -0400
Subject: Re: [2.4.22-rc1] ext3/jbd assertion failure transaction.c:1164
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0308261811240.1021-100000@neptune.local>
References: <Pine.LNX.4.44.0308261811240.1021-100000@neptune.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1061923890.17230.30.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Aug 2003 19:51:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2003-08-26 at 17:15, Pascal Schmidt wrote:

> Sigh. I spoke too soon. Turns out I have two different versions of
> fsx.c around. The one that caused the BUG before still does, but
> it's a different one now:

OK, could you send me both of your versions so that I can try them
here?  I've got an uptodate fsx around myself, but not necessarily the
same version as you, and evidently the precise version matters here.

Thanks,
 Stephen

