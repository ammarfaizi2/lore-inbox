Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBHA5h>; Wed, 7 Feb 2001 19:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130840AbRBHA51>; Wed, 7 Feb 2001 19:57:27 -0500
Received: from winds.org ([207.48.83.9]:14097 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129027AbRBHA5Q>;
	Wed, 7 Feb 2001 19:57:16 -0500
Date: Wed, 7 Feb 2001 19:55:42 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: Jason Ford <jason@heymax.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: aacraid 2.4.0 kernel
In-Reply-To: <PNEPLDDEADCDEBANKDDHMEGPCAAA.jason@heymax.com>
Message-ID: <Pine.LNX.4.21.0102071954440.7965-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Jason Ford wrote:

> Byron,
> 
> I got your patch to compile in fine however it still exhibits the same
> behavior that the older patches did. It looks like the commands sent to the
> controller are still not working correctly as the new subsystem in the
> kernel was rewritten.
> 
> This is the error I get in my messages file when trying to copy from one
> disk partition to another one.
> 
> so on and so on.. Am I doing something wrong?

Nope. It looks horribly broken.  Oh well.. I guess I'd stick to 2.2.19-pre on
the Dell machines for the time being.

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
