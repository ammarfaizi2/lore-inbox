Return-Path: <linux-kernel-owner+w=401wt.eu-S1751483AbWLLSN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWLLSN7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWLLSN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:13:59 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:55397 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751483AbWLLSN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:13:58 -0500
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related [still in
	-git17]
From: Steve Wise <swise@opengridcomputing.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061212173516.1b7dc654@localhost.localdomain>
References: <5a4c581d0612110526j26a07b31q26edc075d4981cd8@mail.gmail.com>
	 <1165873362.20877.22.camel@stevo-desktop>
	 <1165941542.24482.5.camel@stevo-desktop>
	 <20061212173516.1b7dc654@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 12:13:58 -0600
Message-Id: <1165947238.24482.6.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 17:35 +0000, Alan wrote:
> On Tue, 12 Dec 2006 10:39:02 -0600
> Steve Wise <swise@opengridcomputing.com> wrote:
> 
> > All,
> > 
> > Bisecting reveals that this commit causes the problem:
> 
> Yes we know. There is a libata patch missing. As I said - if it is still
> missing by -rc1 I'll sort out a diff.
> 
> Alan

Ah, ok.  Where's the patch?  I'll apply and test it to ensure it fixes
my problem.

Thanks,

Steve.



