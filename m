Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbULDRYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbULDRYy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 12:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbULDRYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 12:24:54 -0500
Received: from main.gmane.org ([80.91.229.2]:55761 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262559AbULDRYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 12:24:53 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <aripollak@gmail.com>
Subject: Re: Linux 2.6.10-rc3
Date: Sat, 04 Dec 2004 12:24:57 -0500
Message-ID: <cosrt1$j67$1@sea.gmane.org>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>	<pan.2004.12.04.09.06.09.707940@nn7.de> <87oeha6lj1.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
In-Reply-To: <87oeha6lj1.fsf@sycorax.lbl.gov>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Romosan wrote:
> well, it's still more than my thinkpad which doesn't want to wake up
> from sleep anymore.

My thinkpad will resume fine if I remove the intel8x0 and intel8x0m ALSA 
modules before going into suspend - works with both APM and ACPI, though 
I don't really use ACPI suspend because the battery drains like crazy.

