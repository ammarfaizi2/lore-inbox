Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129304AbRBTQ6j>; Tue, 20 Feb 2001 11:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129326AbRBTQ6b>; Tue, 20 Feb 2001 11:58:31 -0500
Received: from 194.38.82.urbanet.ch ([194.38.82.193]:64271 "EHLO
	internet.dapsys.com") by vger.kernel.org with ESMTP
	id <S129304AbRBTQ6W> convert rfc822-to-8bit; Tue, 20 Feb 2001 11:58:22 -0500
From: Edouard Soriano <e_soriano@dapsys.com>
Date: Tue, 20 Feb 2001 16:56:57 GMT
Message-ID: <20010220.16565700@dap20.dapsys.com>
Subject: Backward compatibility
To: linux-kernel@vger.kernel.org
CC: linux-gcc@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys,

I am trying to set up a big jump: going from RedHat 6.1 kernel 2.2.12 to
RedHat 7.0 kernel 2.2.16.

For backward compatibility, I would like to compile an ANSI C application 
on 7.0 and run on 6.1.

How is it possible ?

Do I need to copy /lib/libc-2.1.92.so (the one of 7.0) on 6.1 system ?

Many thanks 


