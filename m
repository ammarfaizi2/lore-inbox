Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135993AbRAHW65>; Mon, 8 Jan 2001 17:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136018AbRAHW6r>; Mon, 8 Jan 2001 17:58:47 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:54789 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S135993AbRAHW6h>;
	Mon, 8 Jan 2001 17:58:37 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: f5ibh <f5ibh@db0bm.ampr.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: msg : cannot create ksymoops/nnnnn.ksyms 
In-Reply-To: Your message of "Mon, 08 Jan 2001 23:30:12 BST."
             <200101082230.XAA13551@db0bm.ampr.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jan 2001 09:58:30 +1100
Message-ID: <8279.978994710@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001 23:30:12 +0100, 
f5ibh <f5ibh@db0bm.ampr.org> wrote:
>Ok, I knew that, the problem is why unix.o is loaded so early ? I've not found
>where it is requested / loaded (I've kmod enabled). 

Probably syslog().

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
