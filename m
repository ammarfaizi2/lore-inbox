Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSKYOMH>; Mon, 25 Nov 2002 09:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbSKYOMH>; Mon, 25 Nov 2002 09:12:07 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:34724 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S263326AbSKYOMG>; Mon, 25 Nov 2002 09:12:06 -0500
From: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
Organization: INFN
To: linux-kernel@vger.kernel.org
Subject: Re: i7500 and IRQ assignment
Date: Mon, 25 Nov 2002 15:16:10 +0100
User-Agent: KMail/1.5
References: <233C89823A37714D95B1A891DE3BCE5202AB1994@xch-a.win.zambeel.com>
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1994@xch-a.win.zambeel.com>
Cc: Manish Lachwani <manish@zambeel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200211251516.10261.gabrielli@roma2.infn.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:25, venerdì 22 novembre 2002, Manish Lachwani wrote:
> I experienced the same problem with Supermicro and Intel E7500 board. Look
> on
>
> http://sourceforge.net/projects/lse
>
> for the apic routing patch. This patch, when applied, will solve the issue

uhmm I have tried to apply it against the 2.4.18-18.7.1xsmp by RH, but of sure 
it gave conflicts... I wan not able to resolve them by hand, in paticular I 
can't find the funcion/macro "processor()"...

Has this patch been applied agaist a more recent kernel yet ?!? 2.4.18 is quit 
out of date, expecially for the APIC-related problems...

My final goal is only to have an IRQ assigne to my custom PCI device by the 
SuperMicro P4DP6 MB (e7500), with HT enabled

tnx in advance

-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"

