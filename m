Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262988AbSJBGmy>; Wed, 2 Oct 2002 02:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262990AbSJBGmy>; Wed, 2 Oct 2002 02:42:54 -0400
Received: from as2-4-3.an.g.bonet.se ([194.236.34.191]:27307 "EHLO
	zigo.dhs.org") by vger.kernel.org with ESMTP id <S262988AbSJBGmx>;
	Wed, 2 Oct 2002 02:42:53 -0400
Date: Wed, 2 Oct 2002 08:48:07 +0200 (CEST)
From: =?ISO-8859-1?Q?Dennis_Bj=F6rklund?= <db@zigo.dhs.org>
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: input layer - activate keyboard
In-Reply-To: <3D9A9015.2090503@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210020846280.10497-100000@zigo.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Dave Hansen wrote:

> I have an "IBM Rapidaccess II" keyboard with a few miscellaneous keys 
> in the top and center, with a few more CD-player type controls in the 
> upper left.  You don't need an "activation code", just something to 
> handle its funny scancodes.

For the Rapid Access I you do need activation codes otherwise the keys 
produce nothing.

See http://www.win.tue.nl/~aeb/linux/kbd/scancodes-2.html#ss2.28

-- 
/Dennis

