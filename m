Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbTFLGQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTFLGQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:16:19 -0400
Received: from mail.set-software.de ([193.218.212.121]:44476 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP id S262042AbTFLGQS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:16:18 -0400
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Thu, 12 Jun 2003 06:27:46 GMT
Message-ID: <20030612.6274686@knigge.local.net>
Subject: Re: Linux 2.4.21-rc8
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Frank Cusack <fcusack@fcusack.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L.0306111815100.31893@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0306101845460.30401@freak.distro.conectiva> <20030610165622.A17342@google.com> <Pine.LNX.4.55L.0306102109340.30401@freak.distro.conectiva> <Pine.LNX.4.55L.0306111815100.31893@freak.distro.conectiva>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > Ugh, no fix for nfs_unlink/sillyrename?
> >
> > Damn, right. I'll take a look at it and release -rc9 today or wait for
> > 2.4.22pre.

> It seems this will have to wait for 2.4.22pre.


Hmmm... I don't want to tell you how you have to do your job, but this 
is a known error and (if I followed the postings here correctly) there 
was a fix posted. So why not include it in 2.4.22?

imho the patch have to be included in 2.4.21 and (imho) it is a bad 
practice to release a piece of software with a known bug (especially 
if a fix is available).


Bye
  Michael






