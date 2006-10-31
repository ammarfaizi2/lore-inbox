Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422958AbWJaJqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422958AbWJaJqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423030AbWJaJqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:46:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47020 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422958AbWJaJqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:46:24 -0500
Date: Tue, 31 Oct 2006 01:46:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Marco Berizzi <pupilla@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: where is Linux 2.6.19-rc4?
Message-Id: <20061031014617.15e53b9d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0610310942230.23540@yvahk01.tjqt.qr>
References: <BAY103-F2FD8C4C7A2FBAE2B285BAB2F90@phx.gbl>
	<Pine.LNX.4.61.0610310942230.23540@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 09:43:01 +0100 (MET)
Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >
> > I have seen a message from Linus announcing
> > linux 2.6.19-rc4, but I cannot find the tarball
> > patch. Am I missing anything?
> 
> Either ftp.kernel.org has not received it yet, or it was quickly taken 
> away again after Andrew discovered the patch problem with the bd 
> cleanup.
> 

I suspect that the master.kernel.org -> [www/ftp].kernel.org mirroring
broke.  The files are in the right place on master.kernel.org but didn't
get copied.


