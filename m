Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264007AbTEFSNW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTEFSM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:12:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2177
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263972AbTEFSMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:12:54 -0400
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Marcus Meissner <meissner@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305061320080.11648-100000@xanadu.home>
References: <Pine.LNX.4.44.0305061320080.11648-100000@xanadu.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052241988.1202.36.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 18:26:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 18:23, Nicolas Pitre wrote:
> According to Alan it's nearly possible to configure the block layer out 
> entirely, which would be a good thing to associate with a CONFIG_DISK option 
> too.

David Woodhouse I believe..

