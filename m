Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130324AbRA3UjV>; Tue, 30 Jan 2001 15:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130759AbRA3UjB>; Tue, 30 Jan 2001 15:39:01 -0500
Received: from www.llamacom.com ([209.152.94.130]:48146 "HELO www.llamacom.com")
	by vger.kernel.org with SMTP id <S130338AbRA3Ui4>;
	Tue, 30 Jan 2001 15:38:56 -0500
Date: Tue, 30 Jan 2001 14:38:50 -0600 (CST)
From: Eric Molitor <emolitor@molitor.org>
To: linux-kernel@vger.kernel.org
Subject: Wavelan IEEE driver
Message-ID: <Pine.LNX.4.10.10101301434420.3934-100000@www.llamacom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I updated the Wavelan IEEE driver from 2.3.50 so that it builds with 2.4.0
(The 2.3.50 patch is available at
http://www.fasta.fh-dortmund.de/users/andy/wvlan/ ) It works for me but
I've heard there are issues with firmware 6.xx not initializing.

The patch against 2.4.0 is at http://www.molitor.org/wavelan

- Eric Molitor
  eric@molitor.org
  (I'm not on the kernel mailing list so CC me any replies)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
