Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWARWLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWARWLi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWARWLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:11:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932522AbWARWLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:11:37 -0500
Date: Wed, 18 Jan 2006 14:11:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] e1000 fixes
Message-Id: <20060118141118.78767e3d.akpm@osdl.org>
In-Reply-To: <20060118212449.GA13260@havoc.gtf.org>
References: <20060118212449.GA13260@havoc.gtf.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Let's see how this goes...  if there are further problems, I'll just
>  revert the entire thing, and push these changes (and the previous set)
>  into upstream-2.6.17 branch.
> 
>  I don't mind them updating the defconfig files, even though most people
>  are too slack to worry about it, since its pretty clear the default
>  choice.
> 
> 
>  Please pull from 'upstream-fixes' branch of
>  master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

These patches fix e1000 for me, thanks.
