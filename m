Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSIJRTd>; Tue, 10 Sep 2002 13:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSIJRTc>; Tue, 10 Sep 2002 13:19:32 -0400
Received: from pD954F0D6.dip.t-dialin.net ([217.84.240.214]:8165 "EHLO
	linux-buechse.de") by vger.kernel.org with ESMTP id <S317833AbSIJRTb>;
	Tue, 10 Sep 2002 13:19:31 -0400
Date: Tue, 10 Sep 2002 19:24:15 +0200
From: "Juergen E. Fischer" <fischer@linux-buechse.de>
To: Frederik Himpe <fhimpe@pandora.be>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19: Oops -> problem with aha152x driver
Message-ID: <20020910172415.GA23440@linux-buechse.de>
Mail-Followup-To: Frederik Himpe <fhimpe@pandora.be>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1031596539.2580.12.camel@Jupiter> <1031670457.2291.11.camel@Jupiter>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1031670457.2291.11.camel@Jupiter>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederik,

On Tue, Sep 10, 2002 at 17:07:35 +0200, Frederik Himpe wrote:
> Sorry, the oops I sent was not complete, here is a complete one. It
> seems that the aha152x driver is the problem. If I compile the aha152x
> module from 2.4.18, I don't get the oops.

Upgrade to 2.4.20pre5 or above.


Jürgen

-- 
"I hear that if you play the NT 4.0 CD backwards, you get a satanic message".
"That's nothing. If you play it forward, it installs NT 4.0!"
  -- unknown
