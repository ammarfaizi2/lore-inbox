Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWAZPO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWAZPO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 10:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWAZPO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 10:14:27 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3717 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932346AbWAZPO0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 10:14:26 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Nix <nix@esperi.org.uk>
Subject: Re: [RFC] VM: I have a dream...
Date: Thu, 26 Jan 2006 17:13:03 +0200
User-Agent: KMail/1.8.2
Cc: Diego Calleja <diegocg@gmail.com>, Ram Gupta <ram.gupta5@gmail.com>,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <200601212108.41269.a1426z@gawab.com> <20060123162624.5c5a1b94.diegocg@gmail.com> <87zmlkq6yo.fsf@amaterasu.srvr.nix>
In-Reply-To: <87zmlkq6yo.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601261713.03834.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 January 2006 00:27, Nix wrote:
> On 23 Jan 2006, Diego Calleja wrote:
> > El Mon, 23 Jan 2006 09:05:41 -0600,
> > Ram Gupta <ram.gupta5@gmail.com> escribió:
> > 
> >> Linux also supports multiple swap files . But these are more
> > 
> > There're in fact a "dynamic swap" tool which apparently
> > does what mac os x do: http://dynswapd.sourceforge.net/
> > 
> > However, I doubt the approach is really useful. If you need that much
> > swap space, you're going well beyond the capabilities of the machine.
> 
> Well, to some extent it depends on your access patterns. The backup
> program I use (`dar') is an enormous memory hog: it happily eats 5Gb on
> my main fileserver (an UltraSPARC, so compiling it 64-bit does away with
> address space sizing problems). That machine has only 512Mb RAM, so
> you'd expect the thing would be swapping to death; but the backup
> program's locality of reference is sufficiently good that it doesn't
> swap much at all (and that in one tight lump at the end).

Totally insane proggie.
--
vda
