Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278470AbRKMTSc>; Tue, 13 Nov 2001 14:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278447AbRKMTSW>; Tue, 13 Nov 2001 14:18:22 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:46859 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278313AbRKMTSL>; Tue, 13 Nov 2001 14:18:11 -0500
Date: Tue, 13 Nov 2001 14:18:10 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
Message-ID: <20011113141810.C17578@redhat.com>
In-Reply-To: <20011112232539.A14409@redhat.com> <20011113121022.L1778@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011113121022.L1778@lynx.no>; from adilger@turbolabs.com on Tue, Nov 13, 2001 at 12:10:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 12:10:22PM -0700, Andreas Dilger wrote:
> Is that actually CodingStyle?  Don't see it much in the kernel code...
> The much more common (AFAICS) style to split long function definitions is

That's what Lindent came up with, which evidently needs tweaking.

		-ben
