Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVAHNVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVAHNVn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVAHNVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:21:42 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:18630 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261161AbVAHNVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:21:38 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ksymoops 2.4.10 segfaults 
In-reply-to: Your message of "Sat, 08 Jan 2005 12:01:57 BST."
             <croej5$5b8$1@pD9F86D6F.dip0.t-ipconnect.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Jan 2005 00:21:29 +1100
Message-ID: <29969.1105190489@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Jan 2005 12:01:57 +0100, 
Andreas Hartmann <andihartmann@01019freenet.de> wrote:
>ksymoops segfaults in object.c while computing cmd_strlen, because
>options->target is defined 'null':

I have a fix for this in my ksymoops inbox.  It will be released as
part of ksymoops 2.4.11 later today my time.

