Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288859AbSBRWyt>; Mon, 18 Feb 2002 17:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288870AbSBRWyk>; Mon, 18 Feb 2002 17:54:40 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:25057 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S288859AbSBRWyf>; Mon, 18 Feb 2002 17:54:35 -0500
Date: Mon, 18 Feb 2002 17:54:34 -0500 (EST)
From: Craig <penguin@wombat.ca>
X-X-Sender: carsnau@wombat
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Serial Console changes in linux 2.4.15??
In-Reply-To: <E16cwTv-00073S-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.42.0202181753090.23209-100000@wombat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Alan Cox wrote:

> > If i manually put the lines back (the "#if 0" and "#endif"), then my serial
> > console works just fine.
>
> Except that you broke serial support for CREAD control
>
> > Did someone submit serial.c with the "#if 0" lines removed by accident?
>
> No


If it was removed on purpose, why was the code commented out in the first place?
Why remove it in 2.4.15?  Just curious on why that release.

--
Craig.
+------------------------------------------------------+
http://www.wombat.ca               Why? Why not.
http://www.washington.edu/pine/    Pine @ the U of Wash.
+-------------=*sent via Pine4.42*=--------------------+



