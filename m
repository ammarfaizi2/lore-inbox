Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTDSXB3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 19:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTDSXB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 19:01:29 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:19982 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263396AbTDSXB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 19:01:28 -0400
Date: Sat, 19 Apr 2003 20:13:25 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: John Bradford <john@grabjohn.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-ID: <20030419231325.GC6251@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	John Bradford <john@grabjohn.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030419180421.0f59e75b.skraw@ithnet.com> <200304191622.h3JGMI9L000263@81-2-122-30.bradfords.org.uk> <20030419185201.55cbaf43.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419185201.55cbaf43.skraw@ithnet.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Apr 19, 2003 at 06:52:01PM +0200, Stephan von Krawczynski escreveu:
> On Sat, 19 Apr 2003 17:22:18 +0100 (BST)
> > A RAID-0 array and regular backups are the best way to protect your
> > data.
> 
> RAID-1 obviously ;-)

Have you considered this:

http://www.complang.tuwien.ac.at/reisner/drbd/

?

- Arnaldo
