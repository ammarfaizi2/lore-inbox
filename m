Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266774AbSKUPpb>; Thu, 21 Nov 2002 10:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266767AbSKUPpb>; Thu, 21 Nov 2002 10:45:31 -0500
Received: from mnh-1-06.mv.com ([207.22.10.38]:31492 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S266774AbSKUPpa>;
	Thu, 21 Nov 2002 10:45:30 -0500
Message-Id: <200211211556.KAA02120@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Bryan O'Sullivan" <bos@serpentine.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Get 2.5.48 UML to compile with CONFIG_NFSD=y 
In-Reply-To: Your message of "20 Nov 2002 23:17:10 PST."
             <1037863030.13803.5.camel@camp4.serpentine.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Nov 2002 10:56:20 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bos@serpentine.com said:
> There's a typo in the user-mode-linux syscall table that causes a
> compilation failure with the NFS server enabled.  The attached patch
> applies to BK-current and fixes the problem. 

Thanks, I already had this fix in my pool.

				Jeff

