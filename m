Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271905AbRIMR4F>; Thu, 13 Sep 2001 13:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271948AbRIMRzz>; Thu, 13 Sep 2001 13:55:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:26891 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271905AbRIMRzm>;
	Thu, 13 Sep 2001 13:55:42 -0400
Date: Thu, 13 Sep 2001 14:55:59 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "avi sefati" <sefatiavi@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removing printk  <msg level> from printouts
Message-ID: <20010913145559.C8509@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"avi sefati" <sefatiavi@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <F203W57VqQD9MXzlmOh00010c0b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <F203W57VqQD9MXzlmOh00010c0b@hotmail.com>; from sefatiavi@hotmail.com on Thu, Sep 13, 2001 at 05:48:20PM +0000
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 13, 2001 at 05:48:20PM +0000, avi sefati escreveu:
> When I use printk, the print level gets printed with the message
> e.g. if I use KERN_DEBUG then I get a <7> printed with every message.
 
> How do I stop this number from appearing in the printout?

including an ending '\n' in the previous printk message maybe?

- Arnaldo
