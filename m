Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUAOAq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266369AbUAOAqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:46:55 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:22151 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S266365AbUAOAqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:46:22 -0500
Subject: Re: modprobe failed: digest_null
From: Stian Jordet <liste@jordet.nu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: David Rees <drees@greenhydrant.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040114154836.35614a92.rddunlap@osdl.org>
References: <20040113215355.GA3882@piper.madduck.net>
	 <20040113143053.1c44b97d.rddunlap@osdl.org>
	 <20040113223739.GA6268@piper.madduck.net>
	 <20040113144141.1d695c3d.rddunlap@osdl.org>
	 <20040113225047.GA6891@piper.madduck.net>
	 <20040113150319.1e309dcb.rddunlap@osdl.org>
	 <3156.208.48.139.163.1074037125.squirrel@www.greenhydrant.com>
	 <20040114154836.35614a92.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1074127568.3218.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 01:46:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 15.01.2004 kl. 00.48 skrev Randy.Dunlap:
> I don't know what needs to be done about these, if anything.

As Steve Youngs wrote a couple of days ago:

install <modulename> /bin/true

in your modprobe.conf will get rid of the messages,
if you find them annoying.

Best regards,
Stian

