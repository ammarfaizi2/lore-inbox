Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261930AbSJIUgQ>; Wed, 9 Oct 2002 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbSJIUgQ>; Wed, 9 Oct 2002 16:36:16 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:45050 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261930AbSJIUgQ>; Wed, 9 Oct 2002 16:36:16 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3DA4882A.8000909@pobox.com> 
References: <3DA4882A.8000909@pobox.com>  <20021009144414.GZ26771@phunnypharm.org> <20021009.045845.87764065.davem@redhat.com> <18079.1034115320@passion.cambridge.redhat.com> <20021008.175153.20269215.davem@redhat.com> <200210091149.g99BnWQ5000628@pool-141-150-241-241.delv.east.verizon.net> <7908.1034165878@passion.cambridge.redhat.com> <3DA4392B.8070204@pobox.com> <27367.1034175300@passion.cambridge.redhat.com> 
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ben Collins <bcollins@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: BK kernel commits list 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Oct 2002 21:41:55 +0100
Message-ID: <18069.1034196115@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@pobox.com said:
>  Actually, after subscribing to bk-commits-* and seeing the output, I
> really think the only addition needed is to pipe the output through
> diffstat.

Er, I did that last time you asked. Maybe it'll work better if I cvs update 
on hera after committing the change? :)


--
dwmw2


