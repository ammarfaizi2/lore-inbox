Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUHWVGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUHWVGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbUHWVDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:03:21 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:28751 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S267293AbUHWVBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:01:40 -0400
Message-Id: <200408232101.i7NL1c26024662@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.1
In-reply-to: <cgdjek$klh$1@gatekeeper.tmr.com> 
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Aug 2004 16:01:38 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Aug 2004 16:25:17 EDT, Bill Davidsen wrote:
>permission to open. This allows the admin to put in any filter desired,
> know about vendor commands, etc. It also allows various security
>setups,  the group can be on the user (trusted users) or on a setgid
>program  (which limits the security issues).

  Down such path lies madness :)   This list would have to be maintained for
  most every model, of every drive, for every manufacturer.  The list could
  conceivably change weekly, if not sooner.  This could change, of course, if
  the use of linux would become as ubiquitous as the dominant redmond produnt, 
  and the manufacturers would supply the "mini-port" driver bits, as it were.

  The theory is wonderful.  Until there is enough "clout" to change the 
  manufacturers participation, it is probably futile. :-/

++doug
