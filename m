Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUFAUCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUFAUCp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUFAUCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:02:45 -0400
Received: from codepoet.org ([166.70.99.138]:59279 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S265199AbUFAUBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:01:35 -0400
Date: Tue, 1 Jun 2004 14:01:26 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: Martin Olsson <mnemo@minimum.se>, linux-kernel@vger.kernel.org
Subject: Re: Why is proper NTFS-driver difficult?
Message-ID: <20040601200126.GA26117@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Dax Kelson <dax@gurulabs.com>, Martin Olsson <mnemo@minimum.se>,
	linux-kernel@vger.kernel.org
References: <40BA1FD5.9080902@minimum.se> <1085980819.12504.3.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085980819.12504.3.camel@mentor.gurulabs.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun May 30, 2004 at 11:20:20PM -0600, Dax Kelson wrote:
> On Sun, 2004-05-30 at 19:54 +0200, Martin Olsson wrote:
> > Is there any file system I can use which satisfies these criteria:
> > A) works in both Linux and Windows
> > B) handle >4GB files
> > C) handle 120GB partitions
> 
> UDF meets A & B. I don't if it meets C.

Last time I tried it, Windows would only read UDF from CD/DVD,
not from a hard drive.  Stupid but true...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
