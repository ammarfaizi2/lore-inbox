Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279943AbRJ3MRF>; Tue, 30 Oct 2001 07:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279941AbRJ3MQy>; Tue, 30 Oct 2001 07:16:54 -0500
Received: from ns.viventus.no ([195.18.200.139]:63749 "EHLO viventus.no")
	by vger.kernel.org with ESMTP id <S279938AbRJ3MQr>;
	Tue, 30 Oct 2001 07:16:47 -0500
Date: Tue, 30 Oct 2001 13:20:05 +0100 (CET)
From: Rafael Martinez <rafael@opoint.com>
X-X-Sender: <rafaelma@gauss.viewpoint.no>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Johan <jo_ni@telia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Still having problems with eepro100
In-Reply-To: <E15yXi6-0006Hd-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110301309090.22220-100000@gauss.viewpoint.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Alan Cox wrote:

> > I have been trying all new kernels + the ac patches but nothing
> > seems to work. The fun thing is that I only gets this problem
> > when I am running XFree, is this just a weird coincidence?
>
> Possibly not.
>
> I have one problem box where you have to disable the kernel ACPI stuff but
> the XFree case is a new one to me

I have the same problem with this card and I do not use XFree at all in
my servers

linux-2.4.10-ac12 / 2.4.9 / 2.4.3
eepro100: wait_for_cmd_done timeout!

Rafael Martinez


