Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265656AbSKPIOz>; Sat, 16 Nov 2002 03:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267211AbSKPIOz>; Sat, 16 Nov 2002 03:14:55 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:13320 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265656AbSKPIOy>; Sat, 16 Nov 2002 03:14:54 -0500
Date: Sat, 16 Nov 2002 06:21:43 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47: Link-time error: llc_sap_open when using modules
Message-ID: <20021116082142.GT16673@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
References: <20021111143441.A28688@ma-northadams1b-126.bur.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111143441.A28688@ma-northadams1b-126.bur.adelphia.net>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 11, 2002 at 02:34:41PM +0000, Eric Buddington escreveu:
> This is a long-standing error, I think even discussed before. It goes
> away if I set the LLC options to 'Y' instead of 'M'.
> 
> With most things configured as modules, make bzImage says:

Just fixed, changeset will be heading DaveM's way in minutes.
