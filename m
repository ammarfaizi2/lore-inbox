Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbRGTPQS>; Fri, 20 Jul 2001 11:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbRGTPQI>; Fri, 20 Jul 2001 11:16:08 -0400
Received: from smtp01.fields.gol.com ([203.216.5.131]:33540 "EHLO
	smtp01.fields.gol.com") by vger.kernel.org with ESMTP
	id <S266999AbRGTPQC>; Fri, 20 Jul 2001 11:16:02 -0400
Date: Sat, 21 Jul 2001 00:15:42 +0900
From: Masaru Kawashima <masaruk@gol.com>
To: Rasmus Hansen <moffe@amagerkollegiet.dk>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Re: [MINOR PROBLEM] RTL8139C: transmit timed out
In-Reply-To: <Pine.LNX.4.33.0107201102340.1200-100000@grignard.amagerkollegiet.dk>
In-Reply-To: <E15L7Zp-0006k9-00@smtp01.fields.gol.com>
	<Pine.LNX.4.33.0107201102340.1200-100000@grignard.amagerkollegiet.dk>
X-Mailer: Sylpheed version 0.5.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15Nc0X-0002dN-00@smtp01.fields.gol.com>
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi, Rasmus!

On Fri, 20 Jul 2001 11:03:38 +0200 (CEST)
Rasmus Hansen <moffe@amagerkollegiet.dk> wrote:

> Now the box has been running for nearly a week without any trace of 
> problems, so the patch seems to be fine.

Thank you for your reporting.
The patch has been included in linux-2.4.6-ac3 and above, and also
in linux-2.4.7-pre7 and above.

# Thank you Alan Cox, you've been included my patch for 8139too.c
# in your -ac series.

--
Masaru Kawashima <masaruk@gol.com>
