Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317680AbSGUOev>; Sun, 21 Jul 2002 10:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317682AbSGUOev>; Sun, 21 Jul 2002 10:34:51 -0400
Received: from mnh-1-19.mv.com ([207.22.10.51]:3076 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317680AbSGUOev>;
	Sun, 21 Jul 2002 10:34:51 -0400
Message-Id: <200207110548.AAA01210@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] check shm mount succeeded in shmem_file_setup 
In-Reply-To: Your message of "Sat, 20 Jul 2002 14:19:39 +1000."
             <20020720043607.090A241AC@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jul 2002 00:48:58 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rusty@rustcorp.com.au said:
> Same argument applies to lots of subsystems, but I'd suggest a policy:
> we should be failing the boot rather than coming partially up and
> trying to deal with failures that shouldn't happen. 

OK, I can buy that.

			Jeff

