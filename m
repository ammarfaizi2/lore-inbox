Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbTA1LDu>; Tue, 28 Jan 2003 06:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbTA1LDu>; Tue, 28 Jan 2003 06:03:50 -0500
Received: from [66.70.28.20] ([66.70.28.20]:43530 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S264749AbTA1LDt>; Tue, 28 Jan 2003 06:03:49 -0500
Date: Tue, 28 Jan 2003 11:49:34 +0100
From: DervishD <raul@pleyades.net>
To: Raphael Schmid <Raphael_Schmid@cubus.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128104934.GB51@DervishD>
References: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Raphael :)

> In that veine, another thing I've been puzzled with... can you
> somehow disable virtual consoles (Alt-Fx) completely while still
> maintaining an interface for X to come up on?

    Disable the gettys in your inittab and boot in runlevel 3? (don't
remember the runlevel for the xdm). You need at least one, anyway...

    Raúl
