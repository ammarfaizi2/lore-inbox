Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267182AbTAKKlu>; Sat, 11 Jan 2003 05:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTAKKlu>; Sat, 11 Jan 2003 05:41:50 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:59922 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267182AbTAKKlu>; Sat, 11 Jan 2003 05:41:50 -0500
Date: Sat, 11 Jan 2003 10:50:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL?
Message-ID: <20030111105035.B22580@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20030109222748.GA3993@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030109222748.GA3993@gtf.org>; from jgarzik@pobox.com on Thu, Jan 09, 2003 at 05:27:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 05:27:48PM -0500, Jeff Garzik wrote:
> Anybody know where the source rpm for UnitedLinux kernel is?
> [to be distinguished from kernel-source rpm]
> 
> AFAICS they are not distributing source code to their published kernel
> binaries...  which is a very obvious GPL violation.

They also violate the GPL by including non-GPL compliant code (openssl and
the unisys es7000 support) in their tree, so..

