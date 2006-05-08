Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWEHO5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWEHO5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWEHO5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:57:22 -0400
Received: from secure.htb.at ([195.69.104.11]:10000 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S932341AbWEHO5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:57:21 -0400
Date: Mon, 8 May 2006 16:57:10 +0200
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to read BIOS information
Message-Id: <20060508165710.78e4e3e0.delist@gmx.net>
In-Reply-To: <445F5BC0.9040707@wipro.com>
References: <445F5228.7060006@wipro.com>
	<20060508163630.1059bd9a.delist@gmx.net>
	<445F5BC0.9040707@wipro.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
X-Face: &0P^N,K:@}b8ykW@3d!=n}3D;*Cf{9KYT>>+gcM)XyIMRkBSDg|ur7Zen^BlzmJVr&!;7KT6\t+sHI69\fW(}.=PM+(`w_jnzZ.HbWb/KM"`795_k(&\Lje|'g\cm$4e%Zy*I)hJz-z0!}xkm@!>U0rO{>~[YZUs/=B{}R%#nZ8eBt'{,*>kTTKl_kj'vzrl5|'j5SBiFy#!Sj,p_zl;)q.lpSI\Er"]D`bZY@#+']kJW/YsqvRzi0GR!7ifpt$?]0TYcNs.*wC5OukokPm~R&mmW\q&DL@='khZEET;3ryo[0_mC^K~7,ZvHkj
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1Fd7Ad-0004my-00*v6MMBigKwUI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Madhukar Mythri <madhukar.mythri@wipro.com> (Mon, 08 May
2006 20:24:56 +0530):
> But, HT information is not present in demicode(SMBIOS info..)

Never had a HT system, shouldn't this info be availible through
/var/log/dmesg, /proc/couinfo or /proc/acpi/processor or something like
this?  

sl ritch

Please don't top-post and CC me, I'm reading this list.
