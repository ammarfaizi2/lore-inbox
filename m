Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbSLOIwm>; Sun, 15 Dec 2002 03:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbSLOIwm>; Sun, 15 Dec 2002 03:52:42 -0500
Received: from colina.demon.co.uk ([158.152.133.150]:29826 "EHLO
	colina.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266295AbSLOIwl>; Sun, 15 Dec 2002 03:52:41 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Alcatel speedtouch USB driver and SMP.
References: <m3n0n7hi52.fsf@colina.demon.co.uk>
	<20021215075913.GB2180@kroah.com>
From: Colin Paul Adams <colin@colina.demon.co.uk>
Date: 15 Dec 2002 08:58:14 +0000
In-Reply-To: <20021215075913.GB2180@kroah.com>
Message-ID: <m3hedfhd5l.fsf@colina.demon.co.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

    Greg> On Sun, Dec 15, 2002 at 07:10:33AM +0000, Colin Paul Adams
    Greg> wrote:
    >> Can anyone tell me if the speedtouch driver is SMP safe yet?

    Greg> Which driver?  I know of at least 3 different ones :(

drivers/usb/misc/speedtouch.c

Where are the others?
-- 
Colin Paul Adams
Preston Lancashire
