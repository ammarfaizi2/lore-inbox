Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292997AbSB1CYX>; Wed, 27 Feb 2002 21:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293146AbSB1CXn>; Wed, 27 Feb 2002 21:23:43 -0500
Received: from 216-42-72-159.ppp.netsville.net ([216.42.72.159]:40394 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S293141AbSB1CWo>; Wed, 27 Feb 2002 21:22:44 -0500
Date: Wed, 27 Feb 2002 21:21:48 -0500
From: Chris Mason <mason@suse.com>
To: Oliver.Schersand@BASF-IT-Services.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel Hangs 2.4.16 on heay io on a reiserfs mounted on a lvm partition
Message-ID: <3426050000.1014862908@tiny>
In-Reply-To: <OFBD35F27E.C229DA29-ONC1256B6D.0049B834@bcs.de>
In-Reply-To: <OFBD35F27E.C229DA29-ONC1256B6D.0049B834@bcs.de>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 27, 2002 02:26:53 PM +0100 Oliver.Schersand@BASF-IT-Services.com wrote:

> 
> On heavy load ( ADSM BAckup / Oracle Online Backup to disk with rman System
> hangs.
> You can ping the server but you cannot login local or over network. It is
> not possible
> to switch localy to an other loginscreen. ( Alt-f1 Alt-f2). There is no log
> information on the
> server an no kernel messages send to other server (loghost ) via syslogd.

Is is possible to put this machine on a serial console?  That would make
it much easier to get a stack trace and try to debug this further.

-chris

