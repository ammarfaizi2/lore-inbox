Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbTDRDzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 23:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTDRDze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 23:55:34 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:21206 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262837AbTDRDzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 23:55:33 -0400
Subject: Re: cannot boot 2.5.67
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Paul Rolland <rol@as2917.net>
Cc: "'Pau Aliagas'" <linuxnow@newtral.org>,
       "'lkml'" <linux-kernel@vger.kernel.org>
In-Reply-To: <018401c30505$1a1e6200$6400a8c0@witbe>
References: <018401c30505$1a1e6200$6400a8c0@witbe>
Content-Type: text/plain
Organization: 
Message-Id: <1050638831.595.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 18 Apr 2003 06:07:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-17 at 19:16, Paul Rolland wrote:
> Got the same starting with 2.5.67...
> I took the .config from the booting 2.5.66, made a 2.5.67 kernel,
> and when booting, booh :-(
> 
> It was a RH8 base, Lilo... I'll try tonite to find out which option
> is responsible of that...

I had to disable APIC support in order to be able to boot 2.5.67-mm2.
Don't know if this is your case, but I think it's worth trying :-)

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

