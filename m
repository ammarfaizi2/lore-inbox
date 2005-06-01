Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVFAMhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVFAMhc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVFAMfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:35:13 -0400
Received: from holomorphy.com ([66.93.40.71]:50095 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261374AbVFAMe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:34:28 -0400
Date: Wed, 1 Jun 2005 05:34:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: david.balazic@hermes.si
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
Message-ID: <20050601123413.GE20782@holomorphy.com>
References: <200506011225.j51CPDV23243@lastovo.hermes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506011225.j51CPDV23243@lastovo.hermes.si>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 02:25:13PM +0200, david.balazic@hermes.si wrote:
> Is there any doc about swap size limits ? 
> The mkwap(8) man page claims, that currently the limit is 
> 32 swap areas of maximum 2 gigabyte size (for x86 arch). 
> Is that correct ? 

No.

$ swapon -s
Filename                                Type            Size    Used    Priority
/dev/hda6                               partition       4000144 0       -1


-- wli
