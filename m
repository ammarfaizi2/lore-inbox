Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWAaVkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWAaVkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWAaVkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:40:10 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:46901 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751527AbWAaVkJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:40:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tkvz4nRj3HVddU26Hsk/OjYJFpoDXZCDiRxsfOO+1mleB/nsk67FcagGU9gcZg3orFUH8AIPg2CR7q4b00Zk2dMMePrSZiOyGi0xdTXmBPukcfgqcnuvl+PQj50CLifnU+KcvfyD8RRxK+Pg5UF+kk71J8cHkvDc03SV/lzgMZA=
Message-ID: <d120d5000601311340tee7d35cr177fff5a4072bc29@mail.gmail.com>
Date: Tue, 31 Jan 2006 16:40:07 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/input/: make some functions static
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060131213234.GD3986@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060131213234.GD3986@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Adrian Bunk <bunk@stusta.de> wrote:
> This patch makes some needlessly global functions static.
>

I applied your earlier version of the patch about 2 days ago ;) Will
push it out to Linus soon.

Thank you Adrian.

--
Dmitry
