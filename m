Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUIZEwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUIZEwE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 00:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269492AbUIZEwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 00:52:04 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:36196 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267504AbUIZEwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 00:52:02 -0400
Message-ID: <b2fa632f040925215271e9ecb@mail.gmail.com>
Date: Sun, 26 Sep 2004 10:22:02 +0530
From: Obelix <inguva@gmail.com>
Reply-To: Obelix <inguva@gmail.com>
To: Robert Hancock <hancockr@shaw.ca>, mdlinux7@yahoo.co.in
Subject: Re: Problem in loading Module
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <00d801c4a2c2$e7d8b270$6601a8c0@northbrook>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.jqou8ro.g3cl3k@ifi.uio.no>
	 <00d801c4a2c2$e7d8b270$6601a8c0@northbrook>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004 23:45:46 -0600, Robert Hancock <hancockr@shaw.ca> wrote:
> What kernel headers are you compiling the module against? They must match
> the actual kernel you are using. If you are using Red Hat kernel 2.4.20-6
> then you must compile against Red Hat 2.4.20-6 kernel headers.

you could also try turning off 'module versioning' in which case you
can 'force' load
a module. of course you risk your system when you do this.


-- 
Obelix###
