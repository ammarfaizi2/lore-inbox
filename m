Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbTFRQmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbTFRQmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:42:21 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64673 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265239AbTFRQmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:42:10 -0400
Date: Wed, 18 Jun 2003 12:55:44 -0400
From: Bill Nottingham <notting@redhat.com>
To: Anders Karlsson <anders@trudheim.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Message-ID: <20030618125544.D14270@devserv.devel.redhat.com>
Mail-Followup-To: Anders Karlsson <anders@trudheim.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	LKML <linux-kernel@vger.kernel.org>
References: <3EE66C86.8090708@free.fr> <Pine.LNX.4.55L.0306172019550.31986@freak.distro.conectiva> <1055913307.2436.27.camel@tor.trudheim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1055913307.2436.27.camel@tor.trudheim.com>; from anders@trudheim.com on Wed, Jun 18, 2003 at 06:15:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Karlsson (anders@trudheim.com) said: 
> How about the backported cpufreq patch from Bill Nottingham? Can that
> one go in as well please? It is not a big patch as such and it is
> working as far as I can tell. I have been running it since it was posted
> on the list last week.

It requires the more substantial generic cpufreq backport first. :)

Bill
