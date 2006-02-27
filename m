Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751715AbWB0XjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWB0XjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWB0XjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:39:11 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:36160 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751715AbWB0XjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:39:10 -0500
Date: Mon, 27 Feb 2006 17:38:20 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Question regarding call trace.
In-reply-to: <5KW4H-13v-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <44038D6C.3080907@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5KW4H-13v-11@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> I have a trace that looks like the following, my question is, are the 
> process(es) at the top of the call trace responible for the actual crash 
> of the machine?  Are they the root cause?

This looks like a dump from a SysRq-T keypress to dump the stack on all 
threads.. where is the crash?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

