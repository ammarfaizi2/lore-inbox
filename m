Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTENRoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTENRoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:44:20 -0400
Received: from main.gmane.org ([80.91.224.249]:18565 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263355AbTENRoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:44:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: What exactly does "supports Linux" mean?
Date: 14 May 2003 19:58:37 +0200
Message-ID: <yw1xhe7xo1f6.fsf@zaphod.guide>
References: <20030514021210.GD30766@pegasys.ws> <BKEGKPICNAKILKJKMHCAMEONCPAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Riley Williams" <Riley@Williams.Name> writes:

>  > This is really a trademark related labelling issue. The trademark
>  > allows Linus or his assignee to specify in what way Linux (tm) may
>  > be used in labelling and advertising. Linux is just like other
>  > products with third-party parts and supplies. If Linus's assignee
>  > (Linux international?) where to specify explicit guidelines then
>  > people would know what to expect. Something like:
>  >
>  > Linux certified:
>  >     The mainline kernel has a driver and it has been certified
>  >     as functioning with this hardware by OSDL or some other
>  >     officially sanctioned lab.
>  >
>  > Linux supported:
>  >     The mainline kernel has a driver.
> 
> Fine so far.
> 
>  > Linux compatible:
>  >     Source code driver is available as a patch.
> 
> In other words, if a patch is available for the 1.0.0 kernel, they
> can claim "Linux compatible" ??? That's meaningless...replace with
> something like...
> 
>    Linux 2.2.2 compatible:
>        Source code driver is available as a patch for the stated
>        mainline kernel.
> 
> ...with the specific version to be made explicit. As a minimum, it
> needs to state the actual kernel series the patch is for.

It should also be stated which architectures it works on.  Something
like

        Compatible with Linux 2.4.20 on foo hardware

might be getting closer.

-- 
Måns Rullgård
mru@users.sf.net

