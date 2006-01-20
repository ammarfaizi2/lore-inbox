Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422739AbWATCXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWATCXB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWATCXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:23:01 -0500
Received: from fsmlabs.com ([168.103.115.128]:50838 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1422739AbWATCXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:23:00 -0500
X-ASG-Debug-ID: 1137723769-2366-31-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 19 Jan 2006 18:27:38 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Gilles May <gilles@jekyll.org>
cc: linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: SMP trouble
Subject: Re: SMP trouble
In-Reply-To: <43CFEC68.4070704@jekyll.org>
Message-ID: <Pine.LNX.4.64.0601191826520.1579@montezuma.fsmlabs.com>
References: <43CAFF80.2020707@jekyll.org> <Pine.LNX.4.64.0601181817410.20777@montezuma.fsmlabs.com>
 <43CFD877.4090503@jekyll.org> <Pine.LNX.4.64.0601191132010.1579@montezuma.fsmlabs.com>
 <43CFEC68.4070704@jekyll.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.7578
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Gilles May wrote:

> I don't think it has something to do with the USB card, nor the HDD oder the
> DVD writer connected to it..
> Just to be sure I bought a new USB card with a different chip even, hangs with
> both controllers..
> Besides it freezes aswell if I do the ping and IDE to IDE copies and listening
> music.. Looks like high
> IO loads brings it down, no matter where it comes from..
> The wierd part is that it's only with Linux SMP, not with UP, and no problems
> like that on WindowsXP SP2..
> 
> This starts giving me serious headaches.. ;)

Trying to isolate things here, do you need the ping/network load to 
trigger it? How about only network load?

