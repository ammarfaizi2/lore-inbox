Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133113AbRA2TRv>; Mon, 29 Jan 2001 14:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132952AbRA2TRl>; Mon, 29 Jan 2001 14:17:41 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:27932 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S132901AbRA2TR0>; Mon, 29 Jan 2001 14:17:26 -0500
Message-Id: <200101291918.f0TJIh424038@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
cc: Yi Li <yili@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: XFS file system Pre-Release 
In-Reply-To: Message from "Pedro M. Rodrigues" <pmanuel@myrealbox.com> 
   of "Mon, 29 Jan 2001 20:17:35 +0100." <3A75CFDF.29359.1A1D947A@localhost> 
Content-Transfer-Encoding: 8bit
Date: Mon, 29 Jan 2001 13:18:43 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>    Any information on XFS interoperability with current kernel nfsd? 

You can NFS export XFS, I would have to say that this is not something we
test regularly and you may find problems under high load.

Steve

> 
> 
> Pedro
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
