Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263284AbRFEHwE>; Tue, 5 Jun 2001 03:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbRFEHvy>; Tue, 5 Jun 2001 03:51:54 -0400
Received: from www.wen-online.de ([212.223.88.39]:17925 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263284AbRFEHvo>;
	Tue, 5 Jun 2001 03:51:44 -0400
Date: Tue, 5 Jun 2001 09:51:16 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "YU,SAMMY (HP-Roseville,ex1)" <sammy_yu@hp.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: I/O tracing
In-Reply-To: <6BD67FFB937FD411A04F00D0B74FE87804308CF5@xrose06.rose.hp.com>
Message-ID: <Pine.LNX.4.33.0106050947520.867-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2001, YU,SAMMY (HP-Roseville,ex1) wrote:

> Hi,
> 	Please CC me as I'm not subscribed on the list, thanks.  Not sure if
> this is appropriate forum, is there an existing tool/module for capturing
> all the I/O requests such as:

If you look way back in the archives, you might find references to
'iotracer'.  Ingo Molnar wrote it, and though it's now very ancient,
you can see how he did it and reimpliment without _too_ much trouble
(maybe;).

	-Mike

