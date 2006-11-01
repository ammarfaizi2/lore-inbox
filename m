Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161668AbWKAFLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161668AbWKAFLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161665AbWKAFLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:11:08 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:22235 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161664AbWKAFLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:11:05 -0500
Message-ID: <45482C64.2020902@pobox.com>
Date: Wed, 01 Nov 2006 00:11:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Conke Hu <conke.hu@amd.com>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: AHCI should try to claim all AHCI controllers
References: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conke Hu wrote:
> Hi all,
> 	According to PCI 3.0 spec, ACHI's PCI class code is 0x010601,
> and I suggest the ahci driver had better try to claim all ahci
> controllers, pls see the following patch:

BTW, make sure to always include a Signed-off-by: line in every patch.

See http://linux.yyz.us/patch-format.html and 
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and 
Documentation/SubmittingPatches (in the kernel source tree).

	Jeff


