Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264662AbTFEMzK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 08:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264664AbTFEMzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 08:55:10 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:64655 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264662AbTFEMzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 08:55:09 -0400
Date: Thu, 5 Jun 2003 14:13:00 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: sleep under spinlock detection
Message-ID: <20030605131300.GA31786@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Peter T. Breuer" <ptb@it.uc3m.es>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <200306051205.h55C5At08035@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306051205.h55C5At08035@oboe.it.uc3m.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 02:05:09PM +0200, Peter T. Breuer wrote:
 > I've put a prototype c-code analyser on the net at
 > 
 >  ftp://oboe.it.uc3m.es/pub/Programs/c-1.0.tgz
 > 

--15:06:22--  ftp://oboe.it.uc3m.es/pub/Programs/c-1.0.tgz
           => `c-1.0.tgz'
Resolving oboe.it.uc3m.es... done.
Connecting to oboe.it.uc3m.es[163.117.139.101]:21... connected.
Logging in as anonymous ... Logged in!
==> SYST ... done.    ==> PWD ... done.
==> TYPE I ... done.  ==> CWD /pub/Programs ... done.
==> PASV ... done.    ==> RETR c-1.0.tgz ... 
No such file `c-1.0.tgz'.

		Dave
