Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUCKRaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUCKRaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:30:04 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:61829 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S261442AbUCKRaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:30:03 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 no boot report
Date: Thu, 11 Mar 2004 17:21:08 GMT
Message-ID: <043MYV812@server5.heliogroup.fr>
X-Mailer: Pliant 90
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
>
> Might it be failing initializing APM?  You might try disabling APM, or
> pass 'apm=off' on the kernel command line and see if that helps.  This
> is a server, and APM isn't specifically tested.  We've seen this
> problem on other platforms recently.

Same result: freeze near end of boot with no error message.
