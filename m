Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVAELJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVAELJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVAELJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:09:59 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:28174 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S262322AbVAELJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:09:57 -0500
Message-ID: <41DBCAE5.9010408@tuleriit.ee>
Date: Wed, 05 Jan 2005 13:09:25 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 0.8 (X11/20040923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > On Maw, 2005-01-04 at 22:41, Nicholas Berry wrote:
 > >/ Indeed. AIX (sorry) 5.3 on POWER5 explicitly disables SMT (IBM/
 >>/ hyperthreading) if the load doesn't warrant it./
 >>/ /
 > >/ (Now how about that for Linux?) :)/

 > It would be very nice to do but AFAIK no current processor with
 > hypedthreading lets you do dynamic disabling.

Maybe I am victim of marketing (or poor memory) but wasn't it so that 
x86 instruction HLT was possible to use for single logical processor?


Indrek

