Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbTDANya>; Tue, 1 Apr 2003 08:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbTDANya>; Tue, 1 Apr 2003 08:54:30 -0500
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:57615 "EHLO
	sirius.nix.badanka.com") by vger.kernel.org with ESMTP
	id <S262526AbTDANy3>; Tue, 1 Apr 2003 08:54:29 -0500
Message-Id: <200304011405.h31E5RAx049853@sirius.nix.badanka.com>
Date: Tue, 1 Apr 2003 16:05:23 +0200
From: Henrik Persson <nix@socialism.nu>
To: linux-kernel@vger.kernel.org
Cc: brad@seme.com.au
Subject: Re: via-rhine problem on EPIAV-1Ghz 2.4.21-pre6
In-Reply-To: <20030401063841.GA2894@cy599856-a>
References: <3E88FA24.7040406@seme.com.au>
	<20030401042734.GA21273@gtf.org>
	<3E89171A.8010506@seme.com.au>
	<20030401063841.GA2894@cy599856-a>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003 01:38:41 -0500
Josh McKinney <forming@charter.net> wrote:

> There have been a lot of work done on the 2.5 tree for this driver so if
> possible you could try that.  I seem to remember that there was some
> patches posted here to so maybe you could dig them out of the archives.

When the patches sent to Marcello is applied to 2.4 the 2.5 and the 2.4
drivers should not differ at all, so you could just copy via-rhine.c from
the 2.5 source tree into your tree if you don't want to browse alot of
archives and find all the patches that are needed.

-- 
Henrik Persson  nix@socialism.nu  http://nix.badanka.com
PGP-key: http://nix.badanka.com/pgp  PGP-KeyID: 0x43B68116  
