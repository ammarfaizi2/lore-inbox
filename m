Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbUBYNB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUBYM7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 07:59:47 -0500
Received: from post.tau.ac.il ([132.66.16.11]:41645 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S261312AbUBYM72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 07:59:28 -0500
Date: Wed, 25 Feb 2004 14:58:40 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: OpenGL in the kernel
Message-ID: <20040225125840.GI5546@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <403D2953.7080909@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403D2953.7080909@mail.ru>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.4; VDF: 6.24.0.17; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 02:01:39AM +0300, Dmitry M Shatrov wrote:
> I think this is the right place to ask it for, sorry if not.
> I heard a few about future OpenGL implementation in the Linux kernel, 
> but failed to find any resource on this question. I also remember a 
> message from this list about its author's experiments with Mesa in this 
> key..
> Does anybody work on the subject now? Could you help me with (if there 
> are any) some links or just explain what's this really about?
> 

You are probably thinking of dri which is the kernel side support for
graphic acceleration, not opengl. opengl is a userland thing not kernel.

dri-devel or dri-user is probably a better place. Try dri.sf.net.

> With best regards, Dmitry M. Shatrov
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
