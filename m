Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWHRU2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWHRU2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWHRU2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:28:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:3531 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932514AbWHRU2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:28:38 -0400
Subject: Re: Serial issue
From: Lee Revell <rlrevell@joe-job.com>
To: markh@compro.net
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Fulghum <paulkf@microgate.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <44E6221D.4040008@compro.net>
References: <1155862076.24907.5.camel@mindpipe>
	 <1155915851.3426.4.camel@amdx2.microgate.com>
	 <1155923734.2924.16.camel@mindpipe>  <44E602C8.3030805@microgate.com>
	 <1155925024.2924.22.camel@mindpipe>
	 <Pine.LNX.4.61.0608181512520.19876@chaos.analogic.com>
	 <1155928885.2924.40.camel@mindpipe>
	 <Pine.LNX.4.61.0608181551510.19978@chaos.analogic.com>
	 <44E6221D.4040008@compro.net>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 16:28:36 -0400
Message-Id: <1155932916.2924.47.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 16:25 -0400, Mark Hounschell wrote:
> Take it from someone who actually still uses dumb terminals every day,
> any thing over 9600 baud still requires some kind of flow control for
> reliable consistent operation. Software (Xon/Xoff) and or hardware
> (RTS/RTS/DTE) flow control.
> 

Any idea why the serial console does not work at all with flow control
enabled (regardless of whether the host runs Linux or another OS)?

Lee

