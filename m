Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVKULp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVKULp4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVKULp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:45:56 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:57663 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932198AbVKULpz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:45:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=U4navXRKDWPeo3x89013bupahDyfAZbTtBkY0ujgl4fQ5mC7IMky+KjXp3bFEw64fMUIIucQ9V1P/0Ht/XKUaCajG8rNYqUOXkvDo+EoYnkifC1dTsmw2h7IWyo6tWNye83QNt/1tadxXfE//p96NVNiR/AcukaO1j8I1ikBG68=
Date: Mon, 21 Nov 2005 12:45:44 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Alfred Brons <alfredbrons@yahoo.com>
Cc: pocm@sat.inesc-id.pt, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-Id: <20051121124544.9e502404.diegocg@gmail.com>
In-Reply-To: <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
References: <11b141710511210144h666d2edfi@mail.gmail.com>
	<20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 21 Nov 2005 01:59:15 -0800 (PST),
Alfred Brons <alfredbrons@yahoo.com> escribió:

> Thanks Paulo!
> I wasn't aware of this thread.
> 
> But my question was: do we have similar functionality
> in Linux kernel?
> 
> Taking in account ZFS availability as 100% open
> source, I'm starting think about migration to Nexenta
> OS some of my servers just because of this feature...



There're some rumors saying that sun might be considering a linux port.

http://www.sun.com/emrkt/campaign_docs/expertexchange/knowledge/solaris_zfs_gen.html#10

Q: Any thoughts on porting ZFS to Linux, AIX, or HPUX?
A: No plans of porting to AIX and HPUX. Porting to Linux is currently
being investigated. 

(personally I doubt it, that FAQ was written some time ago and Sun's
executives change their opinion more often than Linus does ;)
