Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWBPW5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWBPW5f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWBPW5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:57:34 -0500
Received: from penobscot.web.itd.umich.edu ([141.211.144.185]:4764 "EHLO
	penobscot.web.itd.umich.edu") by vger.kernel.org with ESMTP
	id S1750775AbWBPW5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:57:34 -0500
Message-ID: <20060216175722.4g6kyjpes4w040ok@engin.mail.umich.edu>
Date: Thu, 16 Feb 2006 17:57:22 -0500
From: Matt Reuther <mreuther@umich.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with SB Live using 2.6.15.3
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
X-Remote-Browser: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1;
	.NET CLR 1.1.4322; .NET CLR 2.0.50727)
X-IMP-Server: 141.211.144.247
X-Originating-IP: 71.4.119.66
X-Originating-User: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't really an answer to your problem, but I had a problem with 
SB Live! when I upgraded my kernel from 2.6.15.3 to 2.6.15.4. On 
boot-up, alsactl restore couldn't enable my sound because of wrong or 
duplicate names in the settings file. I ended up running alsamixer and 
alsactl store to correct it.

Matt
