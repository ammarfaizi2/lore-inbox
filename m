Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUDAH3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 02:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbUDAH3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 02:29:48 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:28115 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262441AbUDAH3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 02:29:45 -0500
Date: Wed, 31 Mar 2004 23:29:17 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: "David S. Miller" <davem@redhat.com>
cc: Sridhar Samudrala <sri@us.ibm.com>, petero2@telia.com,
       marcelo.tosatti@cyclades.com, vladislav.yasevich@hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-rc1 - SCTP 'make xconfig' issue
In-Reply-To: <20040331230555.5c635e40.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0403312328390.9119@localhost.localdomain>
References: <20040328042608.GA17969@logos.cnet> <m2r7vcss6a.fsf@p4.localdomain>
 <Pine.LNX.4.58.0403311418470.7023@localhost.localdomain>
 <20040331230555.5c635e40.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, David S. Miller wrote:

> On Wed, 31 Mar 2004 16:47:04 -0800 (PST)
> Sridhar Samudrala <sri@us.ibm.com> wrote:
>
> > He came up with the following patch that works around this issue with
> > tkparse.  Could you please verify if this works for you?
>
> It seems to fix the problem, should I apply this Sridhar?

Sure. As Peter also has validated, it can be applied.

Thanks
Sridhar
