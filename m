Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266142AbUF2XX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUF2XX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 19:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUF2XX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 19:23:27 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:57576 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266139AbUF2XXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 19:23:07 -0400
Subject: Re: per-process namespace?
From: Ram Pai <linuxram@us.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Mike Waychison <Michael.Waychison@Sun.COM>, linux-kernel@vger.kernel.org
In-Reply-To: <20040629221025.GI12308@parcelfarce.linux.theplanet.co.uk>
References: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com>
	 <40E1DABD.9000202@sun.com>
	 <20040629221025.GI12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1088551367.4788.49.camel@dyn319623-009047021109.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2004 16:22:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 15:10, viro@parcelfarce.linux.theplanet.co.uk
wrote:
 
> Note that sharing parts of namespace (which is basically what automounter
> wants and what we do not have yet) is deliberate act of trust - same as
> having a part of your address space shared with other process.

Al, are you working on this feature(namespace sharing) ?
If so, can we help?  If not, any estimate on the complexity of this
work?

Thanks,
RP

