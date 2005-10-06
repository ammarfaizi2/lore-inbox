Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVJFJzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVJFJzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 05:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVJFJzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 05:55:04 -0400
Received: from smtp.terra.es ([213.4.129.129]:724 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S1750775AbVJFJzD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 05:55:03 -0400
Date: Thu, 6 Oct 2005 11:53:39 +0200
From: grundig@teleline.es
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: leimy2k@gmail.com, 7eggert@gmx.de, nix@esperi.org.uk, marc@perkel.com,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-Id: <20051006115339.6fd736a0.grundig@teleline.es>
In-Reply-To: <20051005232330.GS10538@lkcl.net>
References: <4TiWy-4HQ-3@gated-at.bofh.it>
	<4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz>
	<87k6gsjalu.fsf@amaterasu.srvr.nix>
	<3e1162e60510050755l590a696bx655eb0b7ac05aab6@mail.gmail.com>
	<Pine.LNX.4.58.0510051744480.2279@be1.lrz>
	<3e1162e60510050941l55485cbdgf6135e314a015d8f@mail.gmail.com>
	<20051005232330.GS10538@lkcl.net>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 6 Oct 2005 00:23:30 +0100,
Luke Kenneth Casson Leighton <lkcl@lkcl.net> escribió:

>  there are a lot of legacy apps that no-one wants to modify to get them
>  to create/read /tmp/x-windows/.X11-unix.

What's the point of caring about security for a legacy app if nobody 
is going to fix it if a security problema arises?


http://packages.debian.org/unstable/admin/libpam-tmpdir 

is good enought IMO


