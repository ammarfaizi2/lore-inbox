Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRJTRwc>; Sat, 20 Oct 2001 13:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273870AbRJTRwW>; Sat, 20 Oct 2001 13:52:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54532 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273854AbRJTRwO>;
	Sat, 20 Oct 2001 13:52:14 -0400
Date: Sat, 20 Oct 2001 15:52:46 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jan Labanowski <jkl@osc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.12 IEEE1284_PH_DIR_UNKNOWN undeclared in ./drivers/parport/ieee1284_ops.c
Message-ID: <20011020155245.A1146@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jan Labanowski <jkl@osc.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110201316470.16747-100000@arlen.osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0110201316470.16747-100000@arlen.osc.edu>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 20, 2001 at 01:18:54PM -0400, Jan Labanowski escreveu:
> [1.] One line summary of the problem:
> 2.4.12: IEEE1284_PH_DIR_UNKNOWN undeclared in ./drivers/parport/ieee1284_ops.c

You must be the 1000th person to post this here 8) Just get the latest
2.4.13-pre patch, this is fixed there.

- Arnaldo
