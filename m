Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270416AbTGNBH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 21:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270428AbTGNBH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 21:07:27 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:47886 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S270416AbTGNBH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 21:07:26 -0400
Date: Mon, 14 Jul 2003 11:21:28 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Andreas Gruenbacher <agruen@suse.de>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: BUG at fs/jbd/transaction.c:684 during setxattr on 2.5.75
In-Reply-To: <200307122159.49778.agruen@suse.de>
Message-ID: <Mutt.LNX.4.44.0307141118400.5269-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Andreas Gruenbacher wrote:

> please find attached fixes for three bugs I found while looking into this. 

Works for me (patch needs to be applied with -l).


- James
-- 
James Morris
<jmorris@intercode.com.au>


