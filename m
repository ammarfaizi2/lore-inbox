Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVBAN4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVBAN4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 08:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVBAN4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 08:56:30 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:17359 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262017AbVBAN42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 08:56:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VowudfzbvJIDgD3rtRqv6N/wsXD+W+D/1VxRvuznxgeCT28j3M+Nfs05a33IIq0v0Yl3z0LtKJvzzZS5WaZNr6NrLA0WpnaNMpwwrZqrO5fGqdVu4Rv2zXBKVYx2HISc3ebMTitxN9yILqen5BHLUjk9uP3O2Gk3trLd1ha8G8c=
Message-ID: <d120d5000502010556629fdb48@mail.gmail.com>
Date: Tue, 1 Feb 2005 08:56:28 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Victor Hahn <victorhahn@web.de>
Subject: Re: Really annoying bug in the mouse driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41FF43CD.7080901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E91795.9060609@web.de>
	 <200501280206.06747.dtor_core@ameritech.net> <41FF43CD.7080901@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Feb 2005 09:54:37 +0100, Victor Hahn <victorhahn@web.de> wrote:
> Hi Dmitry,
> 
> thank you for the patch! Unfortunately, I wasn't able to apply it
> correctly, neither to kernel 2.6.10 nor to kernel 2.6.4.

Sorry, I think it will apply to 2.6.11-rc2, I'll try to rediff against
2.6.10 later tonight.

-- 
Dmitry
