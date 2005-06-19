Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVFSTZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVFSTZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 15:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVFSTZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 15:25:09 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:52098 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261186AbVFSTZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 15:25:04 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [2.6.12] x86-64 IO-APIC + timer doesn't work
Date: Sun, 19 Jun 2005 20:25:23 +0100
User-Agent: KMail/1.8.1
Cc: "Andi Kleen" <ak@muc.de>, linux-kernel@vger.kernel.org, ACurrid@nvidia.com
References: <88056F38E9E48644A0F562A38C64FB6004FF1606@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6004FF1606@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506192025.23470.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 Jun 2005 05:57, Pallipadi, Venkatesh wrote:
[snip]
> >
> >Venkatesh, can you push your calibrate_delay patch please? ?
> >
> >
> >-Andi
>
> That patch is in mm tree.
>

Patch cures it on the 1.6 BIOS. Thanks guys (hopefully Andrew will push it 
into 2.6.13).

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
