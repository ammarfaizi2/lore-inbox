Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282809AbRK0Kxi>; Tue, 27 Nov 2001 05:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282904AbRK0Kx2>; Tue, 27 Nov 2001 05:53:28 -0500
Received: from mout01.kundenserver.de ([195.20.224.132]:26911 "EHLO
	mout01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S282809AbRK0KxV>; Tue, 27 Nov 2001 05:53:21 -0500
Date: Tue, 27 Nov 2001 11:57:59 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011127105759.GA2273@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011127095609.89426.qmail@web20503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011127095609.89426.qmail@web20503.mail.yahoo.com>
User-Agent: Mutt/1.3.23.2-current-20011115i (Linux 2.5.1-pre1 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 27 2001, willy tarreau wrote:

> I just tried 2.4.16 with and without your patch.

I applied Andrew's patch to 2.5.1-pre1.

> Without your patch, I could easily
> reproduce the slugginess other people report, mostly
> at the login prompt. But when I applied your patch, I can
> log in immediately, so yes, I can say that your patch
> improves things dramatically.

The same thing here: with the patch applied, things improved, without
I can also easily reproduce unresponsiveness. It definitely fixes
the problem....

-- 
# Heinz Diehl, 68259 Mannheim, Germany
