Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSLQHvS>; Tue, 17 Dec 2002 02:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSLQHvS>; Tue, 17 Dec 2002 02:51:18 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:11909 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S264806AbSLQHvS>; Tue, 17 Dec 2002 02:51:18 -0500
Date: Tue, 17 Dec 2002 08:59:14 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE but no disks
Message-ID: <20021217075914.GB13175@charite.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1040055392.13910.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040055392.13910.52.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:
> People seeing IDE controllers detected but no disks can you try the
> following backport of Ivan's 2.5 PCI fix

This fixes my IDE problem with -ac2 as described in my posting with
Message-ID: <20021211090829.GD8741@charite.de>

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
"Does your computer ever crash?"
"Oh definitely, believe me. We want to make a tool that we can use ourselves
and we know from our own use we can make it a lot better and a lot more
reliable."                                  -- Bill Gates in a BBC interview 

