Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946224AbWKJJ4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946224AbWKJJ4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932826AbWKJJ4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:56:38 -0500
Received: from outmx021.isp.belgacom.be ([195.238.4.202]:3507 "EHLO
	outmx021.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932814AbWKJJ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:56:36 -0500
Message-ID: <45544CD1.6060403@trollprod.org>
Date: Fri, 10 Nov 2006 10:56:33 +0100
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Thunderbird 2.0b1pre (X11/20061109)
MIME-Version: 1.0
To: "Lu, Yinghai" <yinghai.lu@amd.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Adrian Bunk <bunk@stusta.de>,
       Stephen Hemminger <shemminger@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc5 x86_64 irq 22: nobody cared
References: <5986589C150B2F49A46483AC44C7BCA49071D4@ssvlexmb2.amd.com>
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA49071D4@ssvlexmb2.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lu, Yinghai wrote:
> Eric,
> 
> Can you confirm:
> From 2.6.19-rc1, the irq for devices that using io-apic will not change
> between pci=routeirq and not.
> 
> Olivier,
> Can you send lspci -vvxxx for pci=routeirq too?

All files are available here http://olivn.trollprod.org/19-rc5/





