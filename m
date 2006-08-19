Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWHSQmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWHSQmW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWHSQmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:42:22 -0400
Received: from mail.charite.de ([160.45.207.131]:13525 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932397AbWHSQmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:42:22 -0400
Date: Sat, 19 Aug 2006 18:42:18 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling enabled
Message-ID: <20060819164218.GG9537@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <44E1F0CD.7000003@everytruckjob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44E1F0CD.7000003@everytruckjob.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Reidenbach <m.reidenbach@everytruckjob.com>:
> I had made an earlier post concerning very poor network performance 
> after upgrading to 2.6.17 and later kernels.  The solution provided by 
> the e1000 developers was that it was in fact a change to the default tcp 
> window scaling settings and that there was a router somewhere between my 
> computer and its destination.

Are you looking for a traceroute-/mtr-like tool that sends specially
crafted packets and finally comes up with a message like "the router
between x and y is broken"?

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
