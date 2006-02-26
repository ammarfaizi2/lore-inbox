Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWBZTDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWBZTDc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWBZTDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:03:32 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:45710 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932175AbWBZTDb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:03:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=kndW1GZhMZHxHbWZ4he3xOSjPmY4ioxxT5COlAbMRT03xu4Okz06GiNprUkkAsY9TVWOdtI8NpU2UesYjpULxJlhFfBSIfpCzdIMCWXCpBtpq3v+ikXi2eqUPURmnwuwsLKZxeGsx5Zo82kdXucIWyHHaacvoBxXvypYrSj+0bQ=
Date: Sun, 26 Feb 2006 20:03:17 +0100
From: Diego Calleja <diegocg@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sam@ravnborg.org
Subject: Re: Building 100 kernels; we suck at dependencies and drown in
 warnings
Message-Id: <20060226200317.29bc889a.diegocg@gmail.com>
In-Reply-To: <9a8748490602261045q6553b849lac7d8b209a905635@mail.gmail.com>
References: <200602261721.17373.jesper.juhl@gmail.com>
	<20060226192140.4951f5a0.diegocg@gmail.com>
	<9a8748490602261045q6553b849lac7d8b209a905635@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 26 Feb 2006 19:45:52 +0100,
"Jesper Juhl" <jesper.juhl@gmail.com> escribió:

> no tricky Makefile hackery there, just a little shell scripting magic.

Oh sure but "make compiletest" looked nicer ;) 

the compile statistics (http://developer.osdl.org/cherry/compile/)
were also nice, it's a shame it's not updated
