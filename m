Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbULPVHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbULPVHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbULPVHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:07:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:43426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262023AbULPVEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:04:15 -0500
Date: Thu, 16 Dec 2004 13:03:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: ak@suse.de, alan@lxorguk.ukuu.org.uk, Ian.Pratt@cl.cam.ac.uk,
       riel@redhat.com, linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-Id: <20041216130330.6f44c244.akpm@osdl.org>
In-Reply-To: <E1Cf2k0-00069l-00@mta1.cl.cam.ac.uk>
References: <20041216102652.6a5104d2.akpm@osdl.org>
	<E1Cf2k0-00069l-00@mta1.cl.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt <Ian.Pratt@cl.cam.ac.uk> wrote:
>
> I'm not convinced that maintaining xen/i386 in its current form
>  is going to be as hard as Andi thinks. We already share many
>  files unmodified from i386.

How are they shared?  Inclusion, symlinks, makefile references or
copy-n-paste?

