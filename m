Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTKHB5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 20:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTKHB5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 20:57:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65041 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261239AbTKHB5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 20:57:18 -0500
Date: Fri, 7 Nov 2003 20:57:15 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org, <netfilter@lists.netfilter.org>
Subject: Re: kernel: ipt_hook: happy cracking.
In-Reply-To: <200311070648.hA76mRe8007990@turing-police.cc.vt.edu>
Message-ID: <Xine.LNX.4.44.0311072056390.24890-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Nov 2003 Valdis.Kletnieks@vt.edu wrote:

> So I look in my syslogs, and I find a lot of:
> 
> Nov  6 14:36:37 turing-police kernel: ipt_hook: happy cracking.
> 

This is fixed in current bk, see 
http://marc.theaimsgroup.com/?l=linux-netdev&m=106814126307516&w=2



- James 
-- 
James Morris
<jmorris@redhat.com>


