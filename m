Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWCUJET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWCUJET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWCUJET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:04:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22710 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750910AbWCUJES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:04:18 -0500
Subject: Re: 2.6.16 - cpufreq doesn't find Celeron (Pentium4/XEON) processor
From: Arjan van de Ven <arjan@infradead.org>
To: CIJOML <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200603210902.19335.cijoml@volny.cz>
References: <200603210902.19335.cijoml@volny.cz>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 10:04:16 +0100
Message-Id: <1142931856.3077.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 09:02 +0100, CIJOML wrote:
> Hi,
> 
> up to 2.6.15 my kernel worked to find my processor and frequency scalling was 
> possible via cpufreq. I have 


are you sure it was frequency scaling and not throttling? I thought real
frequency scaling was only available on non-Celeron processors.....
(and throttling isn't all that great for power save)

