Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268128AbTCFOHA>; Thu, 6 Mar 2003 09:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268139AbTCFOG7>; Thu, 6 Mar 2003 09:06:59 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:47252 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id <S268128AbTCFOG7>; Thu, 6 Mar 2003 09:06:59 -0500
Subject: Re: SIS900:configuration
From: Alex Bennee <kernel-hacker@bennee.com>
To: Pavel Szalbot <lingeek@centrum.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030306125428Z313276-15843+4665@mail2.centrum.cz>
References: <20030306125428Z313276-15843+4665@mail2.centrum.cz>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1046960239.2505.222.camel@cambridge.braddahead>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1-1mdk 
Date: 06 Mar 2003 14:17:20 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 12:54, Pavel Szalbot wrote:
> Does anybody know, how to configure this ethernet card to work with 
> media type 10BaseT? Ifconfig doesn't work.

Depending on the card type I suspect your looking for either ethtool or
mii-tool.

-- 
Alex, homepage: http://www.bennee.com/~alex/

Fortune's real live weird band names #378:

Jehovah's Waitresses

