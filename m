Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVFOJOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVFOJOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 05:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVFOJOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 05:14:17 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15296 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261354AbVFOJOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 05:14:01 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Wed, 15 Jun 2005 12:13:44 +0300
User-Agent: KMail/1.5.4
References: <f192987705061303383f77c10c@mail.gmail.com>
In-Reply-To: <f192987705061303383f77c10c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506151213.44742.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 13:38, Alexey Zaytsev wrote:
> Instead of adding NLS support to filesystems who don't have it yet, I
> think there should be a global NLS layer, to convert file names from
> any to any encoding, independent of file system and transparently to
> the user.
> 
> So what do you think? Is it all nonsense or maybe I should try to implement it?

I do not understand how this is going to look from userspace perspective.
Can you give examples how this will work?
--
vda

