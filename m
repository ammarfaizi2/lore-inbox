Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283717AbRLZUBE>; Wed, 26 Dec 2001 15:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284800AbRLZUAy>; Wed, 26 Dec 2001 15:00:54 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1542 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S283717AbRLZUAg>; Wed, 26 Dec 2001 15:00:36 -0500
Date: Wed, 26 Dec 2001 18:01:15 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Eliezer@conectiva.com.br, dos@conectiva.com.br, Santos@conectiva.com.br,
        =?iso-8859-1?Q?Magalh=E3es_=3Cmagalhaes=40intime-ne?=@conectiva.com.br,
        =?iso-8859-1?B?dC5jb20uYnI+?=@conectiva.com.br
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: writing device drivers
Message-ID: <20011226180115.F24237@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Eliezer@conectiva.com.br, dos@conectiva.com.br,
	Santos@conectiva.com.br,
	=?iso-8859-1?Q?Magalh=E3es_=3Cmagalha?=@conectiva.com.br,
	=?iso-8859-1?B?ZXNAaW50aW1lLW5ldC5jb20uYnI+?=@conectiva.com.br,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <F68qvDuJhqFo9iLG7c500010b4e@hotmail.com> <01c301c18e45$6e2dd6b0$6400000a@cyber>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01c301c18e45$6e2dd6b0$6400000a@cyber>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 26, 2001 at 05:42:16PM -0200, Eliezer dos Santos Magalhães escreveu:
> where can I find a good paper , or something good that could teach me how to
> write device drivers ?? I really would like to know , mainly network device
> drivers , for example , how could I re-write the rtl8139 driver ?

http://www.xml.com/ldd/chapter/book/index.html

More specifically:

Chapter 14: Network Drivers
http://www.xml.com/ldd/chapter/book/ch14.html

- Arnaldo
