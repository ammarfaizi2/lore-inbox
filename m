Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129240AbQKGCJy>; Mon, 6 Nov 2000 21:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQKGCJo>; Mon, 6 Nov 2000 21:09:44 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:26377 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129240AbQKGCJ2>;
	Mon, 6 Nov 2000 21:09:28 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: ebiederm@xmission.com (Eric W. Biederman)
cc: David Woodhouse <dwmw2@infradead.org>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: Your message of "06 Nov 2000 11:09:41 PDT."
             <m11ywpezve.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 13:09:22 +1100
Message-ID: <9014.973562962@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Nov 2000 11:09:41 -0700, 
ebiederm@xmission.com (Eric W. Biederman) wrote:
>Well we don't have auto unload.

Check crontab, if it contains rmmod -a then you have auto unload.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
