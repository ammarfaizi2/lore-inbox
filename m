Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266918AbSKURUQ>; Thu, 21 Nov 2002 12:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266923AbSKURUQ>; Thu, 21 Nov 2002 12:20:16 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:2825 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266918AbSKURUQ>; Thu, 21 Nov 2002 12:20:16 -0500
Date: Thu, 21 Nov 2002 15:26:55 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Stephane Harnois <sharnois@max-t.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: bonding driver hang in 2.4.19
Message-ID: <20021121172654.GO31594@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Stephane Harnois <sharnois@max-t.com>, linux-kernel@vger.kernel.org
References: <3DDAB712.5000602@max-t.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDAB712.5000602@max-t.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 19, 2002 at 05:11:30PM -0500, Stephane Harnois escreveu:
> [1.] One line summary of the problem:    
> 
> 	  When booting 2.4.19 on a Dell power edge 4600, the system hang 
> 	  when loading the bonding module.

IIRC this is fixed in 2.4.20-pre and rcs
