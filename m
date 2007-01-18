Return-Path: <linux-kernel-owner+w=401wt.eu-S932737AbXARXYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbXARXYy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 18:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbXARXYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 18:24:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:60297 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932737AbXARXYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 18:24:46 -0500
From: Andi Kleen <ak@suse.de>
To: andersen@codepoet.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Date: Fri, 19 Jan 2007 10:23:15 +1100
User-Agent: KMail/1.9.1
Cc: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <200701170829.54540.ak@suse.de> <20070118110028.GA22407@codepoet.org>
In-Reply-To: <20070118110028.GA22407@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701191023.15929.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 January 2007 22:00, Erik Andersen wrote:

> I just tried again and while using iommu=soft does avoid the
> corruption problem, as with previous kernels with 2.6.20-rc5
> using iommu=soft still makes my pcHDTV HD5500 DVB cards not work.

This must be some separate bug and needs to be fixed anyways.

-Andi
