Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWDYAr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWDYAr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 20:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWDYAr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 20:47:27 -0400
Received: from uproxy.gmail.com ([66.249.92.168]:32703 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751274AbWDYAr1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 20:47:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=hPUV1tc6FoPax65vSecZuIIwu50kG+YovSO20pQdjokoCjL+9rGC2pLuBsMCPwetQ8mCxpTls/3vshmChrkT86+TDPsNdpBXd72U4lrBvU90Ar5QSUBxp3w0NeaDm/x3XW4GxeArB3XfIZQej8eymvvgi1s0eT1jEV2PajDoyQM=
Date: Tue, 25 Apr 2006 02:46:25 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Harald Arnesen <harald@skogtun.org>
Cc: jamagallon@able.es, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
Message-Id: <20060425024625.288f616e.diegocg@gmail.com>
In-Reply-To: <87iroyr03a.fsf@basilikum.skogtun.org>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	<mj+md-20060424.201044.18351.atrey@ucw.cz>
	<444D44F2.8090300@wolfmountaingroup.com>
	<1145915533.1635.60.camel@localhost.localdomain>
	<20060425001617.0a536488@werewolf.auna.net>
	<87iroyr03a.fsf@basilikum.skogtun.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 25 Apr 2006 02:05:29 +0200,
Harald Arnesen <harald@skogtun.org> escribió:

> The former is easier to read and understand?

C is not perfect, it could very well get a bit improved so it helps to make 
the code more readable, etc (and I mean: just improvements, not "lets try to
turn C into a OO language"). That however requires modifying the current
C standards, gcc...

But that doesn't justifies adding C++ support to the kernel.
