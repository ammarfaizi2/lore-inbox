Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264249AbTDJX43 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTDJX43 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:56:29 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:27400 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S264249AbTDJX41 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 19:56:27 -0400
Date: Fri, 11 Apr 2003 02:08:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain
 backward compatibility
In-Reply-To: <200304101339.49895.pbadari@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0304110157460.12110-100000@serv>
References: <200304101339.49895.pbadari@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Apr 2003, Badari Pulavarty wrote:

> This patch addresses the backward compatibility with device nodes
> issue. All the new disks will be addressed by only last major.

This nicely demonstrates, that it's not exactly becoming nicer, when one 
has to deal with compatibility. This is one more reason to at least 
consider a more general solution, from which all drivers can benefit from.

bye, Roman

