Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbULSWtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbULSWtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 17:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbULSWtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 17:49:10 -0500
Received: from main.gmane.org ([80.91.229.2]:6364 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261347AbULSWtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 17:49:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <aripollak@gmail.com>
Subject: Re: 2.6.10-rc3-mm1: swsusp
Date: Sun, 19 Dec 2004 17:48:39 -0500
Message-ID: <cq50gt$ppc$1@sea.gmane.org>
References: <200412181852.31942.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
In-Reply-To: <200412181852.31942.rjw@sisk.pl>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Still, unfortunately, today it crashed on suspend and I wasn't able to get any 
> useful information related to the crash,

Have you tried an -rc3-bk13 snapshot? Some changes went in related to 
ALSA drivers and swsusp/ACPI suspend, perhaps it will fix the problem.

