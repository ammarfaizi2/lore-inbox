Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbTA1Kgg>; Tue, 28 Jan 2003 05:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTA1Kgg>; Tue, 28 Jan 2003 05:36:36 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:53679 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S265098AbTA1Kgf>; Tue, 28 Jan 2003 05:36:35 -0500
Date: Tue, 28 Jan 2003 11:45:44 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: John Bradford <john@grabjohn.com>
Cc: Raphael Schmid <Raphael_Schmid@CUBUS.COM>, linux-kernel@vger.kernel.org
Subject: Re: AW: Bootscreen
Message-ID: <20030128104544.GI5239@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <398E93A81CC5D311901600A0C9F29289469372@cubuss2> <200301281032.h0SAWYip000289@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301281032.h0SAWYip000289@darkstar.example.net>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford, Tue, Jan 28, 2003 11:32:34 +0100:
> > Would it be possible/easy (i.e.: the least
> > way of resistance) to modify the kernel so
> > that console initialization does not happen
> > until everything is up and running? What I
> > was up to in the first place was getting into
> > X as fast as possible, and without too many
> > different screens.
> 
> There is a boot option to do this, but I can't remember what it is :-)
> 
> It's something like boot=silent, or something.

"quiet"
It sets console log level to maximum.

> then, you just get:
> 
> LILO loading linux...
> Uncompressing the kernel...
> 
> Welcome to Linux 2.4.20
> login:
> 
> John.
> -
