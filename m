Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVKZTeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVKZTeF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 14:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVKZTeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 14:34:04 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:54426 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1750723AbVKZTeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 14:34:04 -0500
Date: Sat, 26 Nov 2005 21:33:58 +0200
From: Ville Herva <vherva@vianova.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: Folkert van Heusden <folkert@vanheusden.com>, linux-kernel@vger.kernel.org
Subject: Re: capturing oopses
Message-ID: <20051126193358.GF22255@vianova.fi>
Reply-To: vherva@vianova.fi
References: <20051122130754.GL32512@vanheusden.com> <20051126155656.GA3988@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126155656.GA3988@stusta.de>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2005 at 04:56:56PM +0100, you [Adrian Bunk] wrote:
> On Tue, Nov 22, 2005 at 02:07:54PM +0100, Folkert van Heusden wrote:
> 
> > Hi,
> 
> Hi Folkert,
> 
> > My 2.6.14 system occasionally crashes; gives a kernel panic. Of course I
> > would like to report it. Now the system locks up hard so I can't copy
> > the stacktrace. The crash dump patches mentioned in oops-tracing.txt all
> > don't work for 2.6.14 it seems. So: what should I do? Get my digicam and
> > take a picture of the display?
> 
> yes, digicams have become a common tool for reporting Oops'es.

Speaking of which, does anybody know a feasible (as in "not too much harder
than manually typing it in manually") way to OCR characters from vga text
mode screen captures - or even digican shots? 

The vga text mode captures are from a remote administration interface (such
as HP RILOE or vmware gsx console) so they are pixel perfect and OCR should
be doable. The digican shots on the other hand... Well at least it would
have hack value :).

(My personal opinion is that Linus' unwillingness to include anything like
kmsgdump (http://www.xenotime.net/linux/kmsgdump/) is somewhat unfortunate.)


-- v -- 

v@iki.fi

