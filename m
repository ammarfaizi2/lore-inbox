Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129255AbQKSKFM>; Sun, 19 Nov 2000 05:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129157AbQKSKFD>; Sun, 19 Nov 2000 05:05:03 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:35588 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129255AbQKSKE6>;
	Sun, 19 Nov 2000 05:04:58 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Vincent <dtig@ihug.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount /mnt/cdrom ok!but ls segmentation fault... 
In-Reply-To: Your message of "Sun, 19 Nov 2000 20:28:39 +1100."
             <3A179D47.3CAAF427@ihug.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 19 Nov 2000 20:34:50 +1100
Message-ID: <3677.974626490@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000 20:28:39 +1100, 
Vincent <dtig@ihug.com.au> wrote:
>Nov 19 19:46:47 darkstar kernel: Unable to handle kernel paging request
>at virtual address dfdfdfc4
>Nov 19 19:46:47 darkstar kernel: *pde = 00000000
>EIP: 0010:[<c486d5a7>]

See linux/REPORTING-BUGS.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
