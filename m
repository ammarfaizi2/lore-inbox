Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131335AbRCSB5r>; Sun, 18 Mar 2001 20:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131336AbRCSB5h>; Sun, 18 Mar 2001 20:57:37 -0500
Received: from [200.193.161.122] ([200.193.161.122]:36082 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131335AbRCSB5a>; Sun, 18 Mar 2001 20:57:30 -0500
Date: Sun, 18 Mar 2001 06:19:11 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: BERECZ Szabolcs <szabi@inf.elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] kernel BUG at printk.c:458! -- 2.4.2-ac20
Message-ID: <20010318061911.B2461@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	BERECZ Szabolcs <szabi@inf.elte.hu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.A41.4.31.0103190047360.115440-100000@pandora.inf.elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <Pine.A41.4.31.0103190047360.115440-100000@pandora.inf.elte.hu>; from szabi@inf.elte.hu on Mon, Mar 19, 2001 at 02:14:35AM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 19, 2001 at 02:14:35AM +0100, BERECZ Szabolcs escreveu:
> Hi!
> 
> I was copying some files from ext2fs to reiserfs, and then this bug
> occured:
> 
> kernel BUG at printk.c:458!

same thing here, two or three times, I was too lazy to write down the oops
and decode it, will try next time, and I also have reiserfs here in one
partition, 2.4.2-ac18, gcc 2.95.3 as well, further details available upon
request.  

- Arnaldo
