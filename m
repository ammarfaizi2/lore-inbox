Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUDPMxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUDPMxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:53:11 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:35738 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263147AbUDPMxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:53:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.5] problems with synaptics/psmouse/atkbd
Date: Fri, 16 Apr 2004 07:53:00 -0500
User-Agent: KMail/1.6.1
Cc: Mattia Dongili <dongili@supereva.it>, vojtech@suse.cz
References: <20040416102903.GA1790@inferi.kami.home>
In-Reply-To: <20040416102903.GA1790@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404160753.01175.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 April 2004 05:29 am, Mattia Dongili wrote:
> [please could you Cc me as I'm not subscribed to linux-kernel]
> 
> Hi,
> 
> I'm having problems (since 2.6.3 now trying with 2.6.5).
> Main symptom is that my synaptics touchpad isn't detected after a cold
> boot. After a warm boot it's detected correctly though.

Does it help if you load USB modules (*hci-hcd) first and then psmouse?

-- 
Dmitry
