Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUGMKtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUGMKtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 06:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbUGMKtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 06:49:11 -0400
Received: from herkules.viasys.com ([194.100.28.129]:46221 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S264884AbUGMKtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 06:49:08 -0400
Date: Tue, 13 Jul 2004 13:49:05 +0300
From: Ville Herva <vherva@viasys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christopher Swingley <cswingle@iarc.uaf.edu>, linux-kernel@vger.kernel.org
Subject: Re: IRQ issues, (nobody cared, disabled), not USB
Message-ID: <20040713104905.GI16073@viasys.com>
Reply-To: vherva@viasys.com
References: <20040708155356.GG22065@iarc.uaf.edu> <20040708220522.73839ea3.akpm@osdl.org> <20040711083912.GG16073@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711083912.GG16073@viasys.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.25-rc2+mremap-unmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 11:39:12AM +0300, you [Ville Herva] wrote:
> On Thu, Jul 08, 2004 at 10:05:22PM -0700, you [Andrew Morton] wrote:
> > Christopher Swingley <cswingle@iarc.uaf.edu> wrote:
> > >
> > > Greetings!
> > > 
> > > For the past few iterations of 2.6 (including the vanilla 2.6.7 I'm 
> > > running now) I've had this problem:
> > > 
> > >  03:27:26 kernel: irq 7: nobody cared!
> 
> 
> Second Box: Toshiba Satellite Laptop, 650MHz PIII Fedora Core 2 2.6.5-1.358
> and kernel-2.6.6-1.435.2.3 kernels.

Happens with 2.6.7-mm7, too. I added the details to

http://bugme.osdl.org/show_bug.cgi?id=2243



-- v -- 

v@iki.fi

