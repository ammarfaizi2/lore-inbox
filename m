Return-Path: <linux-kernel-owner+w=401wt.eu-S936687AbWLIJoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936687AbWLIJoy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936698AbWLIJoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:44:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60582 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936687AbWLIJox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:44:53 -0500
Date: Sat, 9 Dec 2006 01:44:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061209014445.94322fc2.akpm@osdl.org>
In-Reply-To: <20061209013055.51b26226.randy.dunlap@oracle.com>
References: <20061204204024.2401148d.akpm@osdl.org>
	<20061209013055.51b26226.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 01:30:55 -0800
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> On Mon, 4 Dec 2006 20:40:24 -0800 Andrew Morton wrote:
> 
> > kconfig-new-function-bool-conf_get_changedvoid.patch
> > kconfig-make-sym_change_count-static-let-it-be-altered-by-2-functions-only.patch
> > kconfig-add-void-conf_set_changed_callbackvoid-fnvoid-use-it-in-qconfcc.patch
> > kconfig-set-gconfs-save-widgets-sensitivity-according-to-configs-changed-state.patch
> > pa-risc-fix-bogus-warnings-from-modpost.patch
> > kconfig-refactoring-for-better-menu-nesting.patch
> > kbuild-fix-rr-is-now-default.patch
> > kbuild-dont-put-temp-files-in-the-source-tree.patch
> > actually-delete-the-as-instr-ld-option-tmp-file.patch
> > 
> >  Sent to Sam, but Sam's presently busy.  I might need to make some kbuild
> >  decisions..
> 
> <groan> /me digs thru 65 KB email.
> 
> 
> I can/will help on some of these if you want it...
> 

feel free.  I'm planning on going through the above, see which of then have
a sufficiently high obviousness*urgency product.
