Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbTFAV1T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 17:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbTFAV1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 17:27:19 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:6807 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S264734AbTFAV1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 17:27:18 -0400
Subject: Re: 2.5.70: scripts/Makefile.build fix
From: Kenneth Johansson <ken@kenjo.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stig Brautaset <stig@brautaset.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030601204422.GA1021@mars.ravnborg.org>
References: <20030601184335.GA31452@brautaset.org>
	 <20030601204422.GA1021@mars.ravnborg.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054503639.5045.2.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Jun 2003 23:40:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 22:44, Sam Ravnborg wrote:
> On Sun, Jun 01, 2003 at 07:43:35PM +0100, Stig Brautaset wrote:
> > Hi, 
> > 
> > This patch seems to fix `make V=0' for me.
> 
> Thanks for the patch.
> I do not see the broken behaviour here. Can you provide me with information
> about your system:
> Make version, shell, architecture, distribution.
> 
> I got one report in private mail about make V=0 was broken, and would like
> to find out what is causing the problem.

GNU Make 3.80
GNU bash, version 2.05b.0(1)-release (i386-pc-linux-gnu)
Debian unstable.



