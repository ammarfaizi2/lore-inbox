Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272003AbRIDRck>; Tue, 4 Sep 2001 13:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272034AbRIDRca>; Tue, 4 Sep 2001 13:32:30 -0400
Received: from H131.C54.tor.velocet.net ([204.138.54.131]:555 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S272003AbRIDRcN>;
	Tue, 4 Sep 2001 13:32:13 -0400
Date: Tue, 4 Sep 2001 13:32:27 -0400
From: Mark Frazer <mark@somanetworks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
Message-ID: <20010904133227.B25240@somanetworks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E15eHup-0003ir-00@the-village.bc.nu> <01090410264000.14864@bits.linuxball> <3B950034.17909E5D@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B950034.17909E5D@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Tue, Sep 04, 2001 at 12:24:20PM -0400
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With or without the low-latency patches?

Christopher Friesen <cfriesen@nortelnetworks.com> [01/09/04 12:29]:
> We have a realtime process that tries to run every 50ms.  We're seeing actual
> worst-case scheduling latencies upwards of 300-400ms.
