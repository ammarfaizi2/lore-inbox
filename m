Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSGYWZO>; Thu, 25 Jul 2002 18:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSGYWZO>; Thu, 25 Jul 2002 18:25:14 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:18068 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316592AbSGYWZN>; Thu, 25 Jul 2002 18:25:13 -0400
Date: Fri, 26 Jul 2002 00:27:47 +0200
From: axel@hh59.org
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, jfs-discussion@www-124.southbury.usf.ibm.com
Subject: Re: JFS errors
Message-ID: <20020725222747.GB18216@neon.hh59.org>
Mail-Followup-To: Dave Kleikamp <shaggy@austin.ibm.com>,
	linux-kernel@vger.kernel.org,
	jfs-discussion@www-124.southbury.usf.ibm.com
References: <20020721122932.GA23552@neon.hh59.org> <20020721144212.GA23767@neon.hh59.org> <200207230954.36039.shaggy@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207230954.36039.shaggy@austin.ibm.com>
User-Agent: Mutt/1.4i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave!

On Tue, 23 Jul 2002, Dave Kleikamp wrote:

> happened.  I'm guessing that you have built the kernel without 
> CONFIG_JFS_DEBUG set.  If I'm right, can you set this before you try to 
> stress JFS again.  It may help find the problem earlier.

No, it's built with JFS_DEBUG. That was the first thing I compiled into a
new kernel when I first encountered this.
How can it help you? Shall I provide info from /proc/fs/jfs after oops
occured?
Oops itself I have to handcopy each time. Hard work! ;) But I guess I can
access /proc tree.

Axel Siebenwirth
