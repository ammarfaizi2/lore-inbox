Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTEFLeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTEFLeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:34:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52390
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262572AbTEFLeI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:34:08 -0400
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030505210811.GC7049@wohnheim.fh-wedel.de>
References: <20030505210811.GC7049@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1052218090.28792.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 11:48:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-05 at 22:08, Jörn Engel wrote:
> Hi!
> 
> This patch makes a lot of sense in my eyes, but maybe someone
> disagrees. Applies cleanly to current 2.4.
> 
> Comments?

MSDOS partitions turn up in lots of places beyond x86 boxes. The
port maintainers made their decisions for sound reasons

