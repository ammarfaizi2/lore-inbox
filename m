Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVLERes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVLERes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVLERes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:34:48 -0500
Received: from hera.kernel.org ([140.211.167.34]:34757 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932483AbVLERer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:34:47 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Add tainting for proprietary helper modules.
Date: Mon, 5 Dec 2005 09:34:36 -0800
Organization: OSDL
Message-ID: <20051205093436.44d146e6@localhost.localdomain>
References: <20051203004102.GA2923@redhat.com>
	<Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com>
	<20051205173041.GE12664@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1133804078 21696 10.8.0.222 (5 Dec 2005 17:34:38 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 5 Dec 2005 17:34:38 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO ndiswrapper can't claim legitimately to be GPL, so just
patch that. 

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
