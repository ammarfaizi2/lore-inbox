Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTFCWHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTFCWHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:07:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6530
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261562AbTFCWHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:07:04 -0400
Subject: Re: siimage slow on 2.4.21-rc6-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mauk van der Laan <mauk.lists@maatwerk.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EDD1C87.5090906@maatwerk.net>
References: <3EDD1C87.5090906@maatwerk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054675355.9233.73.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Jun 2003 22:22:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-03 at 23:09, Mauk van der Laan wrote:
> I just tested the siimage driver in 2.4.21-rc6-ac2. The errors i get in 
> -rc6 have disappeared but
> the computer becomes unresponsive (20 seconds between screen switches) 
> when I run bonnie
> and the disk is very slow:

Sounds like your system has switched back to PIO.

