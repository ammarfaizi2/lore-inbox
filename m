Return-Path: <linux-kernel-owner+w=401wt.eu-S1760482AbWLJIKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760482AbWLJIKx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 03:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760487AbWLJIKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 03:10:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60719 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760482AbWLJIKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 03:10:53 -0500
Date: Sun, 10 Dec 2006 00:10:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] kconfig: Only activate UI save widgets when .config
 changed; Take 3
Message-Id: <20061210001044.bd1ea97e.akpm@osdl.org>
In-Reply-To: <200610180023.04978.annabellesgarden@yahoo.de>
References: <200610180023.04978.annabellesgarden@yahoo.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 00:23:04 +0200
Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Hi
> 
> this disables the save-widgets, as long as you haven't changed anything
> yet when you are in the qt/gtk -GUI after
> 	"make xconfig" or "make gconfig".
> There were no objections on kbuild-devel,
>  though no comments neither on "Take 3".
> 
> Should apply from 2.6.19-rc1 onwards.
> 
>       Karsten
> 
> ----------  Weitergeleitete Nachricht  ----------
> 
> Subject: [PATCH 0/4] kconfig: Only activate UI save widgets when .config changed; Take 3
> Date: Dienstag, 10. Oktober 2006 15:33
> From: Karsten Wiese <annabellesgarden@yahoo.de>
> To: kbuild-devel@lists.sourceforge.net
> Cc: Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>
> 
> Hi
> 
> the patchset sent following up tries to implement
> functionality for *config's UIs
> 
> 	to know a .config's change state.
> 
> 	to accordingly
> 		set GUI's save-widgets sensitivity,
> 		remind the user to save changes.
> 

So I'm pretending to be kbuild maintainer and I now realise I simply don't
know what this patch series does.

Can you please explain it a lot more?
