Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbTLLNnR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTLLNnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:43:16 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:3765 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264585AbTLLNnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:43:12 -0500
Date: Fri, 12 Dec 2003 14:43:01 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031212134301.GD6112@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com> <20031211194815.GA10029@wohnheim.fh-wedel.de> <200312111432.12683.rob@landley.net> <20031212125513.GC6112@wohnheim.fh-wedel.de> <1071235698.27730.146.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1071235698.27730.146.camel@tribesman.namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 December 2003 16:28:18 +0300, Vladimir Saveliev wrote:
> 
> Sorry,
> but doesn't truncate do almost exactly what "make hole" is supposed to
> do?

Yeah, *almost* exactly.  Some people happen to care about the almost.

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface. 
-- Doug MacIlroy
