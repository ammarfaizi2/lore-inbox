Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTJNIvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbTJNIvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:51:08 -0400
Received: from ns.suse.de ([195.135.220.2]:18574 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262269AbTJNIvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:51:06 -0400
Date: Tue, 14 Oct 2003 10:50:54 +0200
From: Olaf Hering <olh@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: gcc -msoft-float [Was: Linux 2.6.0-test7 - stability freeze]
Message-ID: <20031014085054.GA29143@suse.de>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <20031013173446.GA13186@suse.de> <20031013205039.GA1638@mars.ravnborg.org> <20031014081228.GA23257@suse.de> <1066120260.5241.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1066120260.5241.3.camel@laptop.fenrus.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Oct 14, Arjan van de Ven wrote:

> ugh

My argument is that this shouldnt be done the usual opensource way
'someone else will fix my shit'. Instead, the driver authors should
notice their mistakes right away.

Linus, please add -msoft-float to test8 and keep it. Thanks.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
