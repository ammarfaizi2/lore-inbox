Return-Path: <linux-kernel-owner+w=401wt.eu-S964939AbXABTfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbXABTfH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbXABTfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:35:06 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:44826 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964939AbXABTfE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:35:04 -0500
Date: Tue, 2 Jan 2007 19:34:59 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86 instability with 2.6.1{8,9}
Message-ID: <20070102193459.GA19894@deepthought>
References: <20070101160158.GA26547@deepthought> <200701021225.57708.lenb@kernel.org> <20070102180425.GA18680@deepthought> <200701021342.32195.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200701021342.32195.lenb@kernel.org>
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 01:42:32PM -0500, Len Brown wrote:
> 
> You might remove and re-insert the DIMMS.
> Sometimes there are poor contacts if the DIMMS are not fully seated and clicked in.
> 
> The real mystery is the 32 vs 64-bit thing.
> Are the devices configured the same way -- ie are they both in IOAPIC mode
> and /proc/interrupts looks the same for both modes?
> 
> -Len

 Too late, I've started memtest-86+.  If it seems ok after an
overnight run, I'll take a look at /proc/interrupts.  How can I tell
it is in IOAPIC mode, please ?  Google was not helpful for this, but
if it's an override, the only things on my command lines are root=
and video= settings.

 Certainly, it seems likely that the configs could be fairly
different in their detail.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
