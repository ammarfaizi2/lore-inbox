Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUC2Qso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 11:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbUC2Qso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 11:48:44 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:34252 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263157AbUC2QVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 11:21:43 -0500
Date: Mon, 29 Mar 2004 18:18:07 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       silverbanana@gmx.de
Subject: Re: usage of RealTek 8169 crashes my Linux system
Message-ID: <20040329181807.B1078@electric-eye.fr.zoreil.com>
References: <40673495.3050500@gmx.de> <4067378B.7070102@pobox.com> <200403290941.27765.ctpm@rnl.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200403290941.27765.ctpm@rnl.ist.utl.pt>; from ctpm@rnl.ist.utl.pt on Mon, Mar 29, 2004 at 09:41:27AM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Martins <ctpm@rnl.ist.utl.pt> :
[...]
>   Is there any way to apply these newer -netdev patches without resorting to 
> -mm tree? This is a production machine, so I'd rather stick to linus' 2.6.x, 
> but if there's no choice I'll try -mm...

Against 2.6.5-rc2:
http://www.fr.zoreil.com/people/francois/misc/20040329-2.6.5-rc2-r8169.c-stable.patch

--
Ueimor
