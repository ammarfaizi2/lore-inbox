Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319427AbSH3Evt>; Fri, 30 Aug 2002 00:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319428AbSH3Evt>; Fri, 30 Aug 2002 00:51:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:6671 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S319427AbSH3Evt>; Fri, 30 Aug 2002 00:51:49 -0400
Date: Fri, 30 Aug 2002 01:48:16 -0300
From: Sergio Bruder <sergio@bruder.net>
To: Anssi Saari <as@sci.fi>, Andre Hedrick <andre@linux-ide.org>,
       vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CD burning at 12x uses excessive CPU, although DMA is enabled
Message-ID: <20020830044816.GB5793@bruder.net>
Reply-To: sergio@bruder.net
Mail-Followup-To: Sergio Bruder <sergio@bruder.net>,
	Anssi Saari <as@sci.fi>, Andre Hedrick <andre@linux-ide.org>,
	vojtech@ucw.cz, linux-kernel@vger.kernel.org
References: <200204092206.02376.roger.larsson@norran.net> <Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org> <20020414123935.GA6441@sci.fi> <20020830043346.GA5793@bruder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830043346.GA5793@bruder.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 01:33:46AM -0300, Sergio Bruder wrote:
> (...)
> Some info about the box in question:
> 
> cat /proc/version
> Linux version 2.4.18-8cl (root@mapi2.distro.conectiva) (gcc version 2.95.4 20010319 (prerelease)) #1 Mon Aug 12 20:27:14 BRT 2002
> 
> (...)

Sorry about replying to myself, but that 2.4.18-8cl is really a
2.4.19-rc2. From the rpm -q kernel-2.4.18-8cl --changelog:

* Qui Ago 08 2002 Eduardo Pereira Habkost <ehabkost@conectiva.com.br>

+ kernel-2.4.18-8cl
- Updated to 2.4.19-rc2
- Removed patches (already on -rc2): sis_main
(...) and so on.

Sergio Bruder
--
http://pontobr.org
pub  1024D/0C7D9F49 2000-05-26 Sergio Devojno Bruder <sergio@bruder.net>
     Key fingerprint = 983F DBDF FB53 FE55 87DF  71CA 6B01 5E44 0C7D 9F49
sub  1024g/138DF93D 2000-05-26
