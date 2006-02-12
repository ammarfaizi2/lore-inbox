Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWBLKiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWBLKiH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWBLKiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:38:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42900 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964844AbWBLKiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:38:06 -0500
Date: Sun, 12 Feb 2006 11:37:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "'austin-group-l@opengroup.org'" <austin-group-l@opengroup.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: The naming of at()s is a difficult matter
In-Reply-To: <43EEACA7.5020109@zytor.com>
Message-ID: <Pine.LNX.4.61.0602121137090.25363@yvahk01.tjqt.qr>
References: <43EEACA7.5020109@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I have noticed that the new ...at() system calls are named in what
> appears to be a completely haphazard fashion.  In Unix system calls,
> an f- prefix means it operates on a file descriptor; the -at suffix (a
> prefix would have been more consistent, but oh well) similarly
> indicates it operates on a (directory fd, pathname) pair.
>
shmat operates on dirfd/pathname?


Jan Engelhardt
-- 
