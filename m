Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVADO3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVADO3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVADO3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:29:20 -0500
Received: from main.gmane.org ([80.91.229.2]:35041 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261664AbVADO3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:29:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: Re: cpu throttling powernow-k8 and acpi in kernel
Date: Tue, 04 Jan 2005 15:29:02 +0100
Message-ID: <41DAA82E.9080206@gmx.net>
References: <41D80CAB.1060903@gmx.net> <20050103094245.GD2473@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 83.215.48.11
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
In-Reply-To: <20050103094245.GD2473@openzaurus.ucw.cz>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems your machine indeed is overheating. Modern cpus produce a lot
> of heat.
> 
> 55C idle temperature seems okay. Open machine and attach your
> own temperature sensor to cpu to verify...
> 				Pavel

I have found this out on my own now, indeed the cpu was overheating, 
there was dust or something in the fans way outside, when i blew into 
the laptop the fan got much more silent and the temp went down. works 
now quite good ;)

