Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSKTT5V>; Wed, 20 Nov 2002 14:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbSKTT5V>; Wed, 20 Nov 2002 14:57:21 -0500
Received: from ns.ithnet.com ([217.64.64.10]:30728 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261600AbSKTT5U>;
	Wed, 20 Nov 2002 14:57:20 -0500
Date: Wed, 20 Nov 2002 21:03:57 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: gallir@uib.es, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: PATCH: Recognize Tualatin cache size in 2.4.x
Message-Id: <20021120210357.70464ff2.skraw@ithnet.com>
In-Reply-To: <20021119120834.GA32004@suse.de>
References: <200211171549.gAHFnSrE021923@mnm.uib.es>
	<20021118190200.GA20936@suse.de>
	<200211182154.52081.gallir@uib.es>
	<20021119120834.GA32004@suse.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002 12:08:34 +0000
Dave Jones <davej@codemonkey.org.uk> wrote:

> On Mon, Nov 18, 2002 at 09:54:52PM +0100, Ricardo Galli wrote:
> 
>  > It's very cosmetic but very annoying for P3 > 1GHz, where Linux <= 2.4.20-preX 
>  > only reports 32 KB of cache and it also seems to ignore the "cachesize" 
>  > parameter. Perhaps it really uses 256KB, but not sure.
> 
> There was a bug related to that parameter, I'm sure if the fix
> went into the same patch, or a separate one. I'll check later.

Sorry for this possibly dumb comment/question:
my Tualatins have 512KB cache on die. Are we all sure that it's used?
/proc says indeed 32KB on 2.4.20-rc2

Regards,
Stephan
