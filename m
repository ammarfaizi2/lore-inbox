Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSJMGLc>; Sun, 13 Oct 2002 02:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbSJMGLc>; Sun, 13 Oct 2002 02:11:32 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:25605 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261434AbSJMGLb>; Sun, 13 Oct 2002 02:11:31 -0400
Date: Sun, 13 Oct 2002 04:17:13 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: sean darcy <seandarcy@hotmail.com>
Cc: hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: VIA KT400 & VT8235 support
Message-ID: <20021013061713.GA7898@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	sean darcy <seandarcy@hotmail.com>, hahn@physics.mcmaster.ca,
	linux-kernel@vger.kernel.org
References: <F32VpMmOlbcrYP0QzBx00016e42@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F32VpMmOlbcrYP0QzBx00016e42@hotmail.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 12, 2002 at 10:11:05PM -0400, sean darcy escreveu:
> Do you mean I can just stick a PCI id (where do I find it?) in some table 
> (filename?)? How?

lspci
lspci -n

- Arnaldo
