Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbTIMMrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 08:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbTIMMrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 08:47:10 -0400
Received: from smtp-node1.eclipse.net.uk ([212.104.129.76]:29970 "EHLO
	smtp1.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S262140AbTIMMrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 08:47:08 -0400
Message-ID: <3F6311B8.2080702@jon-foster.co.uk>
Date: Sat, 13 Sep 2003 13:46:48 +0100
From: Jon Foster <jon@jon-foster.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-gb, en
MIME-Version: 1.0
To: vandrove@vc.cvut.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re:Another keyboard woes with 2.6.0...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> And while we are talking about input devices, I assume that if I want
> driver for frontpanel LCD & up/enter/next buttons, I'm the one who should
> write it, yes?

There is a userspace driver available for most LCDs.  I've only
used it with 2.4, but it should still work with 2.6.  It's
called LCDproc and it's available from:

http://lcdproc.omnipotent.net/?continue=yes

Kind regards,

Jon Foster


