Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVAMRed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVAMRed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVAMRbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:31:49 -0500
Received: from cc15144-a.groni1.gr.home.nl ([217.120.147.78]:22426 "HELO
	boetes.org") by vger.kernel.org with SMTP id S261269AbVAMRam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:30:42 -0500
Date: Thu, 13 Jan 2005 18:30:38 +0059
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
Message-ID: <20050113173100.GC14127@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050113163733.GB14127@boetes.org> <41E6AAE4.3010706@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E6AAE4.3010706@tmr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Han Boetes wrote:
> > And I got two warnings about `int __guard = '\0\0\n\777';'
> >
> > lib/propolice.c:15:15: warning: octal escape sequence out of range
> > lib/propolice.c:15:15: warning: multi-character character constant
>
> Unless you foresee a port of Linux to some 36 bit hardware (like 
> MULTICS) with nine bit bytes, is there a reason not to us \377? I have 
> used 36 (and 48) bit hardware, but I don't expect it to ever get a Linux 
> port.

Could you please refrain from using rhetorical questions, since
they really obscure what you are trying explain and only appear to
intend to embarrass me.

If I understand right what you just said I would suggest you would
have say something like: ``This should most likely be \377. \777
is intended for 36 bit hardware.''



# Han
