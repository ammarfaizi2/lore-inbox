Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUBNIVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 03:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUBNIVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 03:21:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:63475 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261152AbUBNIVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 03:21:11 -0500
From: Emmeran Seehuber <rototor@rototor.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Sat, 14 Feb 2004 09:28:18 +0000
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, Dominik Kubla <dominik@kubla.de>
References: <200402112344.23378.rototor@rototor.de> <20040213070333.GA1555@intern.kubla.de> <200402130223.00339.dtor_core@ameritech.net>
In-Reply-To: <200402130223.00339.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402140928.18473.rototor@rototor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d84d732d8ddd2281dac05c143a411240
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 07:23, Dmitry Torokhov wrote:
[...]
>
> Do you have an active multiplexing controller and does passing i8042.nomux
> option help?
It seems so. At least passing this kernel option makes my PS/2 trackball work 
again :)

Thank you!

cu,
  Emmy
