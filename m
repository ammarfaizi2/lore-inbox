Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289555AbSAJROR>; Thu, 10 Jan 2002 12:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289557AbSAJROH>; Thu, 10 Jan 2002 12:14:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:27154 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289555AbSAJRN5>; Thu, 10 Jan 2002 12:13:57 -0500
Date: Thu, 10 Jan 2002 15:13:49 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] s/TCP_ESTABLISHED/PROTO_ESTABLISHED/g
Message-ID: <20020110171349.GI1010@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020110161629.GF1010@conectiva.com.br> <20020110.082141.74749837.davem@redhat.com> <20020110170626.GG1010@conectiva.com.br> <20020110.090724.104031343.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110.090724.104031343.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 10, 2002 at 09:07:24AM -0800, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Thu, 10 Jan 2002 15:06:26 -0200
>    
>    just to make sure I understood: "to the protocols" means creating
>    IPX_ESTABLISHED, etc, or does it mean having the protocols include tcp.h?
> 
> Include tcp.h

Ok, thats what is being done, works, but I still think its ugly, I'm a
nitpicker, you know 8-)

- Arnaldo
