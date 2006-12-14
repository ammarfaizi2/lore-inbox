Return-Path: <linux-kernel-owner+w=401wt.eu-S1751079AbWLNWEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWLNWEh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWLNWEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:04:37 -0500
Received: from mail.tmr.com ([64.65.253.246]:53657 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbWLNWEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:04:37 -0500
Message-ID: <4581C0B2.1010500@tmr.com>
Date: Thu, 14 Dec 2006 16:22:58 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: noexec=on doesn't work
References: <457B0FD7.2030804@comcast.net>
In-Reply-To: <457B0FD7.2030804@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I'm running on an Athlon 64 in 32-bit mode, running 32-bit Ubuntu with
> kernel 2.6.19 (Ubuntu version 2.6.19-7-generic for the curious;
> compiled for 586).  Apparently, 'noexec=on' on the kernel command line
> does nothing; the NX bit seems to not work.

Straining my memories of i586, I don't think that it even COULD do 
noexec... I don't have any here to try at the moment. In any case an 
option which isn't known or isn't implemented should generate a warning.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
