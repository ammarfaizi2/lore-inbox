Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTKJUZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 15:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbTKJUZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 15:25:30 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:50864 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264104AbTKJUZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 15:25:29 -0500
Date: Mon, 10 Nov 2003 20:24:20 +0000
From: Dave Jones <davej@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>,
       Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: EFAULT reading /dev/mem... - broken x86info
Message-ID: <20031110202420.GY10144@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
References: <20031108162737.GB26350@vana.vc.cvut.cz> <20031110161114.GM10144@redhat.com> <3FAFC1D1.3090309@colorfullife.com> <20031110165654.GS10144@redhat.com> <3FAFC831.4090108@colorfullife.com> <20031110180551.GA20168@vana.vc.cvut.cz> <3FAFDFFF.70100@colorfullife.com> <3FAFE8D5.4020102@kolumbus.fi> <3FAFEB6A.9030206@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFEB6A.9030206@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 08:47:54PM +0100, Manfred Spraul wrote:

 > >afaics, agp uses change_apge_attr() to turn on NOCACHE bit, and 
 > >doesn't remove the mapping.
 > Ops, you are right.

*grin*, I was beginning to think you knew something I didn't..
My cloud of confusion just drifted away 8-)

		Dave

