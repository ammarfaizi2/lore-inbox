Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTJVVSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 17:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTJVVSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 17:18:38 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:3333 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261152AbTJVVSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 17:18:34 -0400
Date: Wed, 22 Oct 2003 18:18:16 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, noah@caltech.edu,
       rddunlap@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Make LLC2 compile with PROC_FS=n
Message-ID: <20031022211815.GA10112@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Stephen Hemminger <shemminger@osdl.org>, noah@caltech.edu,
	rddunlap@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <Pine.GSO.4.58.0310171452540.13905@blinky> <20031020101607.76e02647.shemminger@osdl.org> <20031020223237.31854ab5.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020223237.31854ab5.davem@redhat.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 20, 2003 at 10:32:37PM -0700, David S. Miller escreveu:
> On Mon, 20 Oct 2003 10:16:07 -0700
> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > Why make up a whole separate llc_proc.h file for two prototypes? 
> > Put them on the end of llc.h
> 
> I definitely prefer this version of the fix.
> 
> Since Arnaldo appears to be busy, I'll apply this.
> 
> Thanks Noah and Stephen.

Thanks a lot, I'm back from Europe, hope to become more active again.

Regards,

- Arnaldo
