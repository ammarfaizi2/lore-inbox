Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946118AbWJ0CQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946118AbWJ0CQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 22:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946120AbWJ0CQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 22:16:14 -0400
Received: from ns1.suse.de ([195.135.220.2]:9404 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946118AbWJ0CQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 22:16:13 -0400
From: Andi Kleen <ak@suse.de>
To: Marc Perkel <marc@perkel.com>
Subject: Re: Frustrated with Linux, Asus, and nVidia, and AMD
Date: Thu, 26 Oct 2006 11:42:43 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <453EEE46.9040600@perkel.com> <200610261105.52042.ak@suse.de> <4540FF0E.3080104@perkel.com>
In-Reply-To: <4540FF0E.3080104@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610261142.43717.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 October 2006 11:31, Marc Perkel wrote:
> Andi Kleen wrote:
> >> As of the 2.6.18 released kernel I still had to modify the source code
> >> to keep the kernel from locking up on boot. I haven't tried it with
> >> 2.6.19rcx yet.
> >
> > Modify in what way?
> >
> > -Andi
>
> skip_timer_override = 0

Ah that problem. I'm still waiting for Nvidia to give us the required 
information to fix this properly.

-Andi
