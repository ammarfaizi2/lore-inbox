Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVHYTFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVHYTFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVHYTFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:05:30 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:9599 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932515AbVHYTF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:05:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:to:content-type:content-transfer-encoding:organization:date:message-id:mime-version:x-mailer:from;
        b=pgUg483ZQzidQ03SM4Lo/4m4QMD0Ja/UAGqY5fkQ/ioRMyn1EwKFbbkkKIqQH1T4nL+Vd7/NOpG2NAs8V11bL9uLoHwB4Hov4YFqyzOlDgI8uDks38FXxymR99kzdz5ycE9Na0ypC68cvtsUi5wRBKoMzo6dG9qiVqOSd7oYCnU=
Subject: Re: Initramfs and TMPFS!
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: York University
Date: Thu, 25 Aug 2005 20:05:32 +0100
Message-Id: <1124996732.5848.9.camel@singularity.jenkins>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
From: Alan Jenkins <sourcejedi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 25, 2005 at 12:32:50AM -0400, robo...@godmail.com wrote: 
> > Right, but it would be nice to have that option if initramfs 
> > using tmpfs becomes part of the kernel. 
> 
> But it's not needed so why add bloat? 

I'm not subscribed, so sorry if this doesn't fall into the original
thread.  I'm curious as to why the kernel has to include the decoder -
why you can't just run a self-extracting executable in an empty
initramfs (with a preset capacity if needs be).
