Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUC1Vu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 16:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUC1Vu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 16:50:26 -0500
Received: from mail.gmx.de ([213.165.64.20]:2494 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262194AbUC1Vu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 16:50:26 -0500
X-Authenticated: #1444759
Message-ID: <4067489E.2090400@gmx.de>
Date: Sun, 28 Mar 2004 23:50:22 +0200
From: Bernd Fuhrmann <silverbanana@gmx.de>
Reply-To: silverbanana@gmx.de
Organization: Private
User-Agent: Mozilla Thunderbird 0.5+ (Windows/20040317)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: usage of RealTek 8169 crashes my Linux system
References: <40673495.3050500@gmx.de> <4067378B.7070102@pobox.com>
In-Reply-To: <4067378B.7070102@pobox.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Does Andrew Morton's -mm patches fix it for you?

I haven't tried them yet, because I haven't seen any changes in the 
recent mm-patches to that r8169 driver (just checked all the 
announce.txt files of 2.6.5-rc1&2). Maybe I missed something.

If you think one of these patches might fix it (please tell me the exact 
patch number) I will apply and test it as soon as possible.

Thanks in advance
Bernd Fuhrmann
