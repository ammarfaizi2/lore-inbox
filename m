Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVAYTK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVAYTK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVAYTK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:10:28 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:23732 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262067AbVAYTKD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:10:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Jdxwy2ThFze01g5Qh/sGzq/HZvyZqrwDRigFVfMmyAycN86uNnfc3T6VDnOhMRBXJZVgcAH6SFnqWuE9+9MQG65CsLxsggkQV9pKN0TBsR/Oe1tL7D0aSZdI0iIsFWUmF5sCmwzC9lR/XRcLKTkOutkDt3ruYOZJeUKnLFfBfBE=
Message-ID: <7aaed09105012511104d31fc33@mail.gmail.com>
Date: Tue, 25 Jan 2005 20:10:00 +0100
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
Reply-To: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.11-rc2-mm1
Cc: Brice.Goglin@ens-lyon.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050125184139.GA1346@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <41F59A50.1090203@ens-lyon.fr> <20050125184139.GA1346@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 19:41:39 +0100, Pavel Machek <pavel@ucw.cz> wrote:
> Heh, on my system, I get no cursor, and no letters, either (this is
> vga text console). I *can* see the backgrounds, for example if I run
> aumix I see colored blocks... Framebuffer does not seem to work,
> either.
> 
> Letters are present for a while during boot; not sure what makes them
> go away.

I get the same thing, text disappairs after a second or something like
that. Framebuffer has no effect.

-- 
Mvh / Best regards
Espen Fjellvær Olsen
espenfjo@gmail.com
Norway
