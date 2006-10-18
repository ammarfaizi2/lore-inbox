Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWJRCOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWJRCOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 22:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWJRCOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 22:14:31 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:27025 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750978AbWJRCOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 22:14:31 -0400
Subject: RE: Touchscreen hardware hacking/driver hacking.
From: Lee Revell <rlrevell@joe-job.com>
To: Greg.Chandler@wellsfargo.com
Cc: dtor@insightbb.com, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, andi@rhlx01.fht-esslingen.de
In-Reply-To: <E8C008223DD5F64485DFBDF6D4B7F71D020C5EB1@msgswbmnmsp25.wellsfargo.com>
References: <E8C008223DD5F64485DFBDF6D4B7F71D020C5EB1@msgswbmnmsp25.wellsfargo.com>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 22:14:33 -0400
Message-Id: <1161137674.15860.55.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 16:28 -0500, Greg.Chandler@wellsfargo.com wrote:
> Both of you suggested checking the PS/2 under windows, unfortunatly I
> know of no "sniffer" type drivers or apps
> to listen directly on a logical PS/2 interface.  If you know where I
> can
> find something like that that would be of more help than anything at
> this point.
> 

You can use SoftICE to set an IO breakpoint on the PS/2 port.  It is not
free though...

Lee

