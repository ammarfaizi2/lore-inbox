Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281879AbRLCIvk>; Mon, 3 Dec 2001 03:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284471AbRLCIuf>; Mon, 3 Dec 2001 03:50:35 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:63503 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284404AbRLBX1f>;
	Sun, 2 Dec 2001 18:27:35 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: hps@intermeta.de, jgarzik@mandrakesoft.com, lm@bitmover.com,
        linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue 
In-Reply-To: Your message of "Sun, 02 Dec 2001 15:21:57 -0800."
             <20011202.152157.123925377.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Dec 2001 10:27:22 +1100
Message-ID: <30026.1007335642@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Dec 2001 15:21:57 -0800 (PST), 
"David S. Miller" <davem@redhat.com> wrote:
>   From: Keith Owens <kaos@ocs.com.au>
>   Date: Sat, 01 Dec 2001 12:17:03 +1100
>   
>   What is ugly in aic7xxx is :-
>
>You missed:
>
>* #undef's "current"

Where?  fgrep -ir current 2.4.17-pre2/drivers/scsi/aic7xxx did not find it.

