Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTDXVNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbTDXVNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:13:06 -0400
Received: from codepoet.org ([166.70.99.138]:1954 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S263479AbTDXVNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:13:00 -0400
Date: Thu, 24 Apr 2003 15:25:09 -0600
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA and 2.4.x
Message-ID: <20030424212508.GI14661@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Apr 24 2003 - 08:35:48 EST, David van Hoose wrote:
> Is there a ALSA backport to 2.4.x anywhere? 

I was crazy enough to take ALSA 0.9.2 and made it into a patch vs
2.4.x a week or two ago.  I just prefer to have ALSA be part of
the kernel rather than needing to compile it seperately all the
time.  The patch, along with various other things, is included as
part of my 2.4.21-rc1-erik kernel:

    http://codepoet.org/kernel/

This is what I am running locally, and it works for me,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
