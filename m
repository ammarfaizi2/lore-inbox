Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275843AbRKMQTC>; Tue, 13 Nov 2001 11:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRKMQSx>; Tue, 13 Nov 2001 11:18:53 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:22790 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S275843AbRKMQSm>; Tue, 13 Nov 2001 11:18:42 -0500
Date: Tue, 13 Nov 2001 17:18:36 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x has finally made it!
Message-ID: <20011113171836.A14967@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0111131002200.14971-100000@gurney>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0111131002200.14971-100000@gurney>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Alastair Stevens wrote:

> For those who haven't seen it yet, Moshe Bar at BYTE.com has revisited his
> Linux 2.4 vs FreeBSD benchmarks, using 2.4.12 in this case:
> 
>  http://www.byte.com/documents/s=1794/byt20011107s0001/1112_moshe.html

Wow. That person is knowledgeable... NOT. Turning off fsync() for mail
is just as good as piping it to /dev/null. See RFC-1123.
