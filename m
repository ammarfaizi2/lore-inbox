Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312385AbSCUQD3>; Thu, 21 Mar 2002 11:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312383AbSCUQDT>; Thu, 21 Mar 2002 11:03:19 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:4337 "EHLO
	host140.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S312381AbSCUQDE>; Thu, 21 Mar 2002 11:03:04 -0500
Date: Thu, 21 Mar 2002 16:02:41 +0000 (GMT)
From: Bernd Schmidt <bernds@redhat.com>
X-X-Sender: <bernds@host140.cambridge.redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: last write to drive issued with write cache off?
In-Reply-To: <E16o5EB-0005aS-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203211601460.20748-100000@host140.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, Alan Cox wrote:

> > "To prevent loss of customer data, it is recommended that the last write access
> > before power off be issued after setting the write cache off."
> 
> Standard 2.4 doesn't do this. 2.4.19-ac issues cache flushes.

Is this what's been causing my harddrives to make funny noises on shutdown
recently?


Bernd

