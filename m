Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272020AbRIQSLF>; Mon, 17 Sep 2001 14:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271995AbRIQSKz>; Mon, 17 Sep 2001 14:10:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28434 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272020AbRIQSKl>; Mon, 17 Sep 2001 14:10:41 -0400
Date: Mon, 17 Sep 2001 15:06:56 -0400
From: Flavio Bruno Leitner <flavio@conectiva.com.br>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange ps line
Message-ID: <20010917150656.A20241@conectiva.com.br>
In-Reply-To: <E15iy3X-00077o-00@the-village.bc.nu> <XFMail.20010917173700.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
In-Reply-To: <XFMail.20010917173700.pochini@shiny.it>; from pochini@shiny.it on Mon, Sep 17, 2001 at 05:37:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 05:37:00PM +0200, Giuliano Pochini wrote:
> 
> >From "ps axuw":
> 
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> httpd     5020  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
> httpd     5022  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
> httpd     5025  0.0  0.0 589505315 0 ?       ZL   16:46   0:00 [getcod.cgi <defunct>]
> httpd     5049  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
> 
> That cgi doesn't lock memory and surely I don't have so much memory.

Look at http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC14
maybe this can help you. 

-- 
Flávio Bruno Leitner  http://fly.to/fbl
Conectiva Linux http://www.conectiva.com.br/
