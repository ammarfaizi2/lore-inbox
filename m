Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288016AbSABXrG>; Wed, 2 Jan 2002 18:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288029AbSABXpj>; Wed, 2 Jan 2002 18:45:39 -0500
Received: from marine.sonic.net ([208.201.224.37]:1297 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S287998AbSABXox>;
	Wed, 2 Jan 2002 18:44:53 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 2 Jan 2002 15:44:48 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102234447.GD29462@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C338DCC.3020707@free.fr> <Pine.LNX.4.33.0201022349200.427-100000@Appserv.suse.de> <20020102174824.A21408@thyrsus.com> <3C339681.3080100@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C339681.3080100@free.fr>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 12:23:45AM +0100, Lionel Bouton wrote:
> Your whole point here is not to avoid several su instead of 1?

Seems like the point is being able to do ``make autoconfig'' as a normal
user, then su and make install modules_install.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
