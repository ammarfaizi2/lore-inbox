Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWEHOgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWEHOgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWEHOgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:36:43 -0400
Received: from secure.htb.at ([195.69.104.11]:20493 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S932262AbWEHOgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:36:42 -0400
Date: Mon, 8 May 2006 16:36:30 +0200
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to read BIOS information
Message-Id: <20060508163630.1059bd9a.delist@gmx.net>
In-Reply-To: <445F5228.7060006@wipro.com>
References: <445F5228.7060006@wipro.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
X-Face: &0P^N,K:@}b8ykW@3d!=n}3D;*Cf{9KYT>>+gcM)XyIMRkBSDg|ur7Zen^BlzmJVr&!;7KT6\t+sHI69\fW(}.=PM+(`w_jnzZ.HbWb/KM"`795_k(&\Lje|'g\cm$4e%Zy*I)hJz-z0!}xkm@!>U0rO{>~[YZUs/=B{}R%#nZ8eBt'{,*>kTTKl_kj'vzrl5|'j5SBiFy#!Sj,p_zl;)q.lpSI\Er"]D`bZY@#+']kJW/YsqvRzi0GR!7ifpt$?]0TYcNs.*wC5OukokPm~R&mmW\q&DL@='khZEET;3ryo[0_mC^K~7,ZvHkj
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1Fd6qe-0003qL-00*1mjTG7sI0P6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Madhukar Mythri <madhukar.mythri@wipro.com> (Mon, 08 May
2006 19:44:00 +0530):
> Hi,
>      Im new to this group.
> I want to get some information from BIOS. i.e i want to know whether 
> Hyperthreading is Enabled/Disabled(as per BIOS settings)  from an user
> applications program.

Maybe dmidecode[1] is something for you. However, I'm not sure about HT
there. It's userspace.

apt-get install dmidecode or
[1] http://www.nongnu.org/dmidecode/

sl ritch
