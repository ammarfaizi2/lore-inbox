Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTJGNcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTJGNcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:32:20 -0400
Received: from main.gmane.org ([80.91.224.249]:39394 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262123AbTJGNcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:32:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: devfs and udev
Date: Tue, 07 Oct 2003 15:32:10 +0200
Message-ID: <yw1xllrxdvhh.fsf@users.sourceforge.net>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:AS9Gtxyuzi8CY828IyKK9vqnE6k=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman <kakadu_croc@yahoo.com> writes:

> I think the two things which really prevented devfs from working were:

It's always worked just fine for me.

> 1. The namespace was too different from the original and required additional
> configuration to maintain compatibility (devfsd and changes to core /etc
> files.)

Since when do Linux developers resist changes?

> 2. Devfs was not immediately picked up my the major distros, which meant that
> any moderate end-user who wanted to use it would have to be careful when
> setting it up or risk massive core breakage due to the changed device nodes
> (initscripts failing and the like).

Had it been pushed harder, they probably would have done it.

> I used it for a very long time, personally; it was a good idea, and it had
> potential. If the namespace that had been used was the same flat namespace as
> the original /dev, it would have probably taken off. As it is, I think udev
> is the new way of doing this (I haven't used it yet).

The different naming was one thing i liked about devfs.  Go read the
archives from a couple of years ago, and see that the exact same
arguments that were used to promote devfs, are now said to be bad
things.  This sudden change is what I don't understand, and how the
not-working udev is supposed to be able to replace devfs.

-- 
Måns Rullgård
mru@users.sf.net

