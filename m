Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282019AbRKVCra>; Wed, 21 Nov 2001 21:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282020AbRKVCrU>; Wed, 21 Nov 2001 21:47:20 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:11784 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282019AbRKVCrE>;
	Wed, 21 Nov 2001 21:47:04 -0500
Date: Thu, 22 Nov 2001 00:46:09 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 not supported by kernel !!!!!
Message-ID: <20011122004609.C2216@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Miguel Maria Godinho de Matos <Astinus@netcabo.pt>,
	linux-kernel@vger.kernel.org
In-Reply-To: <EXCH01SMTP01eaCYPct00001063@smtp.netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EXCH01SMTP01eaCYPct00001063@smtp.netcabo.pt>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 21, 2001 at 11:07:31PM +0000, Miguel Maria Godinho de Matos escreveu:
> fs ext3 not supported by kernel

First: 2.4.14 doesn't have ext3 integrated. Ok, but the kernel should
fallback to ext2, it seems you didn't selected ext2...

- Arnaldo
