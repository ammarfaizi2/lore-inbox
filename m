Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261781AbSJIP35>; Wed, 9 Oct 2002 11:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbSJIP35>; Wed, 9 Oct 2002 11:29:57 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:24994 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261781AbSJIP34>; Wed, 9 Oct 2002 11:29:56 -0400
Subject: Re: softdog doesn't work on 2.4.20-pre10?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210091727.00406.roy@karlsbakk.net>
References: <200210091607.32769.roy@karlsbakk.net>
	<200210091712.10987.roy@karlsbakk.net>
	<1034177580.1970.52.camel@irongate.swansea.linux.org.uk> 
	<200210091727.00406.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 16:46:14 +0100
Message-Id: <1034178374.2066.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 16:27, Roy Sigurd Karlsbakk wrote:
> it doesn't tell if the softdog supports the send-'V'-before-close-file command 
> to shut it down

That is a shutdown in no way out mode. In default mode when you close
the watchdog it stops

