Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTDER3n (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 12:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTDER3n (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 12:29:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28045
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261710AbTDER3n (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 12:29:43 -0500
Subject: Re: 2.4.21-pre7 and ac97_code.c compilation problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lars <lhofhansl@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E8E8AA4.3070302@yahoo.com>
References: <3E8E8AA4.3070302@yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049560971.25758.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Apr 2003 17:42:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-05 at 08:49, Lars wrote:
> It seems prepatch 2.4.21-pre7 changes ac97_codec.c without making
> matching changes in ac97_codec.h... Just a heads up.
> 
> The changes to ac97_codec.c are isolated enough so that I could easily
> reverse that part of the patch to get it to work.
> 
> I'm not subscribed to this list, please CC me on any responses.

Marcelo applied a random subset of the changes I sent him. Grab the -ac
tree

