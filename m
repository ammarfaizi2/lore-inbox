Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbSL1ADz>; Fri, 27 Dec 2002 19:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbSL1ADz>; Fri, 27 Dec 2002 19:03:55 -0500
Received: from relay04.roc.frontiernet.net ([66.133.131.37]:22755 "EHLO
	relay04.roc.frontiernet.net") by vger.kernel.org with ESMTP
	id <S265266AbSL1ADy>; Fri, 27 Dec 2002 19:03:54 -0500
Date: Fri, 27 Dec 2002 19:12:13 -0500
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Highpoint HPT370 not working in 2.4.18+ versions
Message-ID: <20021227191213.G16539@newbox.localdomain>
References: <5.1.1.6.2.20021226012834.037b9558@192.168.2.131>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.1.6.2.20021226012834.037b9558@192.168.2.131>; from system_lists@nullzone.org on Thu, Dec 26, 2002 at 01:36:28AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

system_lists@nullzone.org on Thu 26/12 01:36 +0100:
> i have a Highpoint 370 which doesnt work in new kernel releases.

for 2.4.18 please try the patch:

ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/patch-2.4.18-ac3.gz

> I'm just using 2.4.18 becouse other version upper doesnt detect the
> Raid HW card.

what card?
