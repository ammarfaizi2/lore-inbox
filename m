Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWBTWTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWBTWTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWBTWTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:19:39 -0500
Received: from xenotime.net ([66.160.160.81]:40097 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030218AbWBTWTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:19:38 -0500
Date: Mon, 20 Feb 2006 14:20:35 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Nish Aravamudan" <nish.aravamudan@gmail.com>
Cc: adobriyan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Mozilla Thunderbird posting instructions wanted
Message-Id: <20060220142035.6ccbe6d9.rdunlap@xenotime.net>
In-Reply-To: <29495f1d0602201330i78d5538bwe4c771593f09ea97@mail.gmail.com>
References: <20060220210349.GA29791@mipter.zuzino.mipt.ru>
	<29495f1d0602201330i78d5538bwe4c771593f09ea97@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2006 13:30:59 -0800 Nish Aravamudan wrote:

> On 2/20/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > This  POS is pretty popular among kernel janitors, so, can someone who
> > is successfully using it, please, post crystally clear step-by-step
> > instructions on how to send a foo.patch:
> >         inline
> >         with tabs preserved
> >         with long lines preserved
> >
> > Sending plain text attachments is OK with me, but, heh, people do post
> > patches inline and screw themselves.
> 
> Randy D. eventually agreed that there was a way, IIRC:
> 
> http://lkml.org/lkml/2005/12/27/191
> 
> Probably can work your way through the thread to figure out how (I use mutt :)

Yep, the odd part is not to disable html email.
Then when composing a message, there is a drop-down box for a format
selection.  While the cursor is in the body area, change the format
from default "Body text" to Preformat, and then copy-n-paste the patch.
At least that's what worked for me.

---
~Randy
