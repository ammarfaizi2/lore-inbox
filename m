Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278214AbRJMAQV>; Fri, 12 Oct 2001 20:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278212AbRJMAQM>; Fri, 12 Oct 2001 20:16:12 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20489 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278132AbRJMAQB>;
	Fri, 12 Oct 2001 20:16:01 -0400
Date: Fri, 12 Oct 2001 21:16:33 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: joeja@mindspring.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 && 2.4.12
Message-ID: <20011012211633.D9395@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	joeja@mindspring.com, linux-kernel@vger.kernel.org
In-Reply-To: <Springmail.105.1002931906.0.04908300@www.springmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Springmail.105.1002931906.0.04908300@www.springmail.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 12, 2001 at 08:11:46PM -0400, joeja@mindspring.com escreveu:

> Last night I tried 2.4.12.  I patched a stock 2.4.10 kernel with
> 2.4.11.donuse and then with 2.4.12.  It compiled the kernel, but make
> modules failed miserably with all sorts of errors and warnings.  Should I
> have patched my 2.4.10 with 2.4.12 and just skipped over 2.4.11?  The

nope, you have to apply patch-2.4.12 on top of patch-2.4.11 on top of
linux-2.4.10.

> patching went fine, the compiling was a mess.

> Needless to say that I have reverted back to 2.4.10 which seems to be
> doing fine on my machine.

2.4.11 and 2.4.12 are not recommended AFAIK, stay with 2.4.10 or go to
2.4.13-pre1.
 
- Arnaldo
