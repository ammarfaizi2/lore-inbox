Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUESPvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUESPvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUESPvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:51:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:986 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264246AbUESPu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:50:26 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] implement TIOCGSERIAL in sn_serial.c
Date: Wed, 19 May 2004 11:50:08 -0400
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, pfg@sgi.com,
       Erik Jacobson <erikj@sgi.com>
References: <200405191109.51751.jbarnes@engr.sgi.com> <200405191138.04086.jbarnes@engr.sgi.com> <20040519164156.A27947@infradead.org>
In-Reply-To: <20040519164156.A27947@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405191150.08967.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 19, 2004 11:41 am, Christoph Hellwig wrote:
> > Pat is working on that and should have a patch ready to post soon (is
> > that right Pat?).  In the meantime, we need this little bit.
>
> Huh?  We need this little bit isn't exactly a patch desciption that gets
> your patch included.

Umm... I described the patch in the last mail.  I don't know when Pat will 
have the conversion to the serial core interface done, but I have a need for 
this ioctl now.  If you want to wait for the full blown version, then so be 
it, I just hope it comes soon.

Jesse
