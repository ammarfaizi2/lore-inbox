Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVBARZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVBARZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVBARZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:25:26 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:4389 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262075AbVBARZW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:25:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lXkDJ3Fl5ji5qvV2Q3eb0TUSSYojDyQJibqbowEx423tlYNi6MNwC2VgszK0QaeGY5Pn6IWgDfUorYbYi20jq6b1IUvqFrpf+id4s2Hb7U812vrWCDb9C0DroLLQW1ouiK84YWEBeb1ilLr3eWsjl20XSZoBXfJH0sYPknAW+AQ=
Message-ID: <7f800d9f050201092536734026@mail.gmail.com>
Date: Tue, 1 Feb 2005 09:25:21 -0800
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: 2.6.11-rc2-mm2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <41FEA724.1060404@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20050129131134.75dacb41.akpm@osdl.org>
	 <7f800d9f05013113157978f158@mail.gmail.com> <41FEA724.1060404@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 22:46:12 +0100, Laurent Riffard
<laurent.riffard@free.fr> wrote:
> Le 31.01.2005 22:15, Andre Eisenbach a écrit :
> > My PCMCIA slot (yenta_socket) doesn't work anymore with
> > 2.6.11-rc2-m2. See the dmesg output below. It works fine with
> > 2.6.11-rc1-mm1.
> 
> I had the same type of problem while loading modules.
> 
> Fixed this evening by the following patch :
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110715631504335

The patch worked for me as well.

Thanks,
   Andre
