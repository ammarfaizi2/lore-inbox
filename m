Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282022AbRKVCxU>; Wed, 21 Nov 2001 21:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282023AbRKVCxK>; Wed, 21 Nov 2001 21:53:10 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:33288 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282022AbRKVCwy>;
	Wed, 21 Nov 2001 21:52:54 -0500
Date: Thu, 22 Nov 2001 00:52:04 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Lee Chin <leechinus@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel modules
Message-ID: <20011122005204.F2216@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Lee Chin <leechinus@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011120203519.66550.qmail@web14302.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011120203519.66550.qmail@web14302.mail.yahoo.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 20, 2001 at 12:35:19PM -0800, Lee Chin escreveu:

> I know that if you write a kernel module, and dont modify any kernel
> source to get the module written, then you dont have to open the source
> for your module... but what if you include header files with in line
> functions?

Well, most probably all the binary only drivers use inline functions in
kernel headers, but as Alan says, talk to your lawyer 8)

- Arnaldo
