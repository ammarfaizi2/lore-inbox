Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVC2JMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVC2JMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVC2JMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:12:40 -0500
Received: from mail.upce.cz ([195.113.124.33]:15530 "EHLO mail.upce.cz")
	by vger.kernel.org with ESMTP id S262269AbVC2JMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:12:15 -0500
Message-ID: <42491BE4.8080609@seznam.cz>
Date: Tue, 29 Mar 2005 11:12:04 +0200
From: "kern.petr@seznam.cz" <kern.petr@seznam.cz>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [SATA] libata-dev queue updated
References: <422FDDCE.3020806@pobox.com>
In-Reply-To: <422FDDCE.3020806@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik napsal(a):

> Merged recent upstream changes into libata-dev queue.  No new patches 
> have found their way into libata-dev since last email.
>
> BK URL, Patch URL, and changelog attached.
>
> Note that the patch is diff'd against 2.6.11-bk6, which won't exist 
> until four hours after this email is sent.
>
>     Jeff 

It is hard to add support for VIA VT6420 PATA channel (SATA works fine)? 
Does anybody working on it? I can help with beta testing this driver. 
(The way through via82cxxx.c don't working.)

Is it possible add to To-do list to sata_via.c or add this support to 
driver?

sata_via.c:
---cut here---
   To-do list:
   * VT6420 PATA support <= new line
   * VT6421 PATA support
 */
---cut here---

Petr Novák,
kern.petr@seznam.cz

