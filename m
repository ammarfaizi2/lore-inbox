Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbTCVMfZ>; Sat, 22 Mar 2003 07:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262699AbTCVMfZ>; Sat, 22 Mar 2003 07:35:25 -0500
Received: from holomorphy.com ([66.224.33.161]:11923 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262685AbTCVMfY>;
	Sat, 22 Mar 2003 07:35:24 -0500
Date: Sat, 22 Mar 2003 04:46:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jos Hulzink <josh@stack.nl>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.65: oops: EIP at current_kernel_time +0x0f/0x40
Message-ID: <20030322124607.GB30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jos Hulzink <josh@stack.nl>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <200303221252.12226.josh@stack.nl> <20030322041758.3ee1fed8.akpm@digeo.com> <200303221334.41355.josh@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303221334.41355.josh@stack.nl>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 01:34:41PM +0100, Jos Hulzink wrote:
> Gee, you guys are good. Now I'm only left wondering how this setting could be 
> reset to PIV, while I'm sure I set it to PII (as you can see from earlier 
> postings, I managed to get it running till a SCSI lockup caused by probably 
> IRQ prioblems). For now I'll not blame the kernel and tell myself I'm stupid 
> ;-)

Which SCSI? I've been seeing numerous aic7xxx badnesses ca. whatever bk
snapshot 2.5.65-mm2 was based on. Still looking for the use-after-free...


-- wli
