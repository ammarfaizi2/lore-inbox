Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270707AbTGUT5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270711AbTGUT5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:57:45 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:413 "HELO heather-ng.ithnet.com")
	by vger.kernel.org with SMTP id S270707AbTGUT5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:57:44 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 21 Jul 2003 22:12:45 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: andrea@suse.de, mason@suse.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, maillist@jg555.com
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-Id: <20030721221245.1a2d423a.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.55L.0307211624410.26518@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva>
	<1058297936.4016.86.camel@tiny.suse.com>
	<Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva>
	<20030718112758.1da7ab03.skraw@ithnet.com>
	<20030721162033.GA4677@x30.linuxsymposium.org>
	<20030721212453.4139a217.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307211624410.26518@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 16:40:27 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> If that doesnt make us spot the problem, can you PLEASE find out in which
> -pre the problem starts ?

Right away I can tell you there was no problem up to the pre that did not boot
on my box, I thing it was pre3, right? Meaing pre1 and pre2 work.

pre5 was the first one that booted again - and the first I can tell has the
problem.

I can "port" the mini-patch from chris back to pre3 and try this one as next
step...

Regards,
Stephan
