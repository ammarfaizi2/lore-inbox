Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264817AbSJVRdT>; Tue, 22 Oct 2002 13:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSJVRdT>; Tue, 22 Oct 2002 13:33:19 -0400
Received: from mout0.freenet.de ([194.97.50.131]:55684 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S264817AbSJVRdS>;
	Tue, 22 Oct 2002 13:33:18 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: PCI: Failed to allocate resource in 2.4.20pre10 and 11 - broken	IRQ-router?
Date: Tue, 22 Oct 2002 19:43:33 +0200
Organization: privat
Message-ID: <ap42o5$32s$1@ID-44327.news.dfncis.de>
References: <fa.mq6dl3v.5lgkh3@ifi.uio.no> <fa.j9607mv.185k5hc@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1035308613 3164 192.168.1.3 (22 Oct 2002 17:43:33 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.1
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:

> On Tue, Oct 22, 2002 at 01:48:45PM +0100, Andreas Hartmann wrote:
>> CMD64x is switched off in *both* config-files of the kernel. I switched
>> it on in the 2.4.20pre10 kernel, but the result is the same.
> 
> Ugh. It's a silly typo in the "transparent bridges" patch.

The patch is working fine :-)!


Thank you Ivan,
regards,
Andreas Hartmann
