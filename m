Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWAITZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWAITZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWAITZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:25:16 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:12160 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751154AbWAITZO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:25:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=I1ArtVqSUnIiF6HOBXKcaQ308ah0LrY0qTzuWdAeD8RfPdhAeWD6zXj7vnsAtUAsiCJAwHqSm128uwgiCaY2NecddACBHiD2/ecSY6cInHb5l8ZFn0BbKF5iVxrWPAz6UzkVI4LTSABfmrQlCfj9WJRKP4uA/e0JIaiKcU+E0O4=
Date: Mon, 9 Jan 2006 20:24:54 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: yarick@it-territory.ru, lkml@metanurb.dk, s0348365@sms.ed.ac.uk,
       andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
 can't for a long time
Message-Id: <20060109202454.7548b566.diegocg@gmail.com>
In-Reply-To: <1136822827.6659.25.camel@localhost.localdomain>
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	<200601091403.46304.yarick@it-territory.ru>
	<1136813783.8412.4.camel@localhost>
	<200601091656.48355.yarick@it-territory.ru>
	<1136822827.6659.25.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 09 Jan 2006 16:07:07 +0000,
Alan Cox <alan@lxorguk.ukuu.org.uk> escribió:

> Currently Linux performance loading large binaries is at least
> perceptually worse than Windows (some of that is perceptual tricks
> windows apps pull, some of it real). There is an openoffice.org related
> analysis project currently under way to sort that out.

Desktop performance has become a such hot topic that I wonder if
it would be worth to setup a dedicated mailing list somewhere
where all the parts involved (kernel, kde/gnome, x.org, libc) can
analyze what are the real problems are.


