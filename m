Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVJOBvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVJOBvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 21:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVJOBvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 21:51:08 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:26283 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751018AbVJOBvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 21:51:07 -0400
Subject: Re: Forcing an immediate reboot
From: Lee Revell <rlrevell@joe-job.com>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43505F86.1050701@perkel.com>
References: <43505F86.1050701@perkel.com>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 21:50:49 -0400
Message-Id: <1129341050.23895.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-14 at 18:46 -0700, Marc Perkel wrote:
> Is there any way to force an immediate reboot as if to push the reset 
> button in software? Got a remote server that i need to reboot and 
> shutdown isn't working.

If it has Oopsed, and the "reboot" command does not work, then all bets
are off - kernel memory has probably been corrupted.

Get one of those powerstrips that you can telnet into and power cycle
things remotely.

Lee

