Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312380AbSDCTle>; Wed, 3 Apr 2002 14:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSDCTlY>; Wed, 3 Apr 2002 14:41:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42507 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312380AbSDCTlL>; Wed, 3 Apr 2002 14:41:11 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
Date: 3 Apr 2002 11:40:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a8fls5$mur$1@cesium.transmeta.com>
In-Reply-To: <m11ydwu5at.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m11ydwu5at.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
>
> Linus please apply,
> 
> This patch makes not changes to the generated object code.
> 
> Instead removes the assumption the code is linked to run at 0.  The
> binary code is already PIC, this makes the build process the same way,
> making the build requirements more flexible. 
> 

Flexible in what way?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
