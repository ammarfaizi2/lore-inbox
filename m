Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTD1SQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTD1SQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:16:45 -0400
Received: from niwot.scd.ucar.edu ([128.117.8.223]:19635 "EHLO
	niwot.scd.ucar.edu") by vger.kernel.org with ESMTP id S261249AbTD1SQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:16:45 -0400
Date: Mon, 28 Apr 2003 12:28:56 -0600
From: Craig Ruff <cruff@ucar.edu>
To: Mark Grosberg <mark@nolab.conman.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
Message-ID: <20030428182856.GA18075@ucar.edu>
References: <Pine.LNX.4.53.0304280855240.16444@chaos> <Pine.BSO.4.44.0304281219420.22115-100000@kwalitee.nolab.conman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.44.0304281219420.22115-100000@kwalitee.nolab.conman.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 28 Apr 2003, Richard B. Johnson wrote:
> 
> > The Unix API provides execve(), fexecve(), execv(), execle(),
> > execl(), execvp(), and execlp() for what you call 'exec'. So
> > there is no 'fork and exec' as you state.

By the way, the latest ISO/IEC 9945-1:2002 POSIX standard defines the
posix_spawn* functions which provide this fork/exec style of operation.
