Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbTGJP7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269345AbTGJP7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:59:48 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:42380 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S269296AbTGJP7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:59:47 -0400
Date: Thu, 10 Jul 2003 09:14:24 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client errors with 2.5.74?
Message-ID: <20030710091424.A831@google.com>
References: <20030710054121.GB27038@mail.jlokier.co.uk> <20030710060744.GA27308@mail.jlokier.co.uk> <16141.15548.109496.967464@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16141.15548.109496.967464@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Jul 10, 2003 at 12:15:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 12:15:24PM +0200, Trond Myklebust wrote:
> >>>>> " " == Jamie Lokier <jamie@shareable.org> writes:
>      > - Every so often, the client's kernel log gets:
>      >       kernel: nfs: server 192.168.1.1 not responding, timed out
> 
> Sigh... I hate soft mounts...  Have I said that before? 8-)

Is "timed out" the key that this is a soft mount?  Trond, I would suggest
that whenever you log this, you also log a message "... do not report
a bug, use a hard mount" or some such. :-)

/fc
