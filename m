Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVLCQTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVLCQTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 11:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVLCQTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 11:19:14 -0500
Received: from mail.dvmed.net ([216.237.124.58]:3819 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751273AbVLCQTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 11:19:13 -0500
Message-ID: <4391C575.6030501@pobox.com>
Date: Sat, 03 Dec 2005 11:19:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Heinz Mauelshagen <mauelshagen@redhat.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com> <20051201144745.GI2782@redhat.com> <20051203112208.GC31216@merlin.emma.line.org>
In-Reply-To: <20051203112208.GC31216@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Matthias Andree wrote: > In my message I asked whether
	it was feasible for you to look at > FreeBSD's "ataraid(4)" driver to
	learn the Intel ICHx-R SoftRAID format. > I know FreeBSD understands
	this format, and dmraid did not when I sent > the email. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> In my message I asked whether it was feasible for you to look at
> FreeBSD's "ataraid(4)" driver to learn the Intel ICHx-R SoftRAID format.
> I know FreeBSD understands this format, and dmraid did not when I sent
> the email.

Read the readme :)

http://people.redhat.com/~heinzm/sw/dmraid/readme

The following ATARAID types are supported:

Highpoint HPT37X
Highpoint HPT45X
Intel Software RAID
[...]

