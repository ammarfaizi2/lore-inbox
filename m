Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSKTPvm>; Wed, 20 Nov 2002 10:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSKTPvl>; Wed, 20 Nov 2002 10:51:41 -0500
Received: from elin.scali.no ([62.70.89.10]:16647 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S261354AbSKTPvB>;
	Wed, 20 Nov 2002 10:51:01 -0500
Date: Wed, 20 Nov 2002 17:00:29 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [BUG?] Xeon with HyperThreading and linux-2.4.20-rc2
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000FDD858E@fmsmsx103.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0211201657300.13800-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Nakajima, Jun wrote:

> As Hugh pointed out, the MPS table should report the physical processors
> only even if HT is enabled. The major reason is to support legacy OSes that
> don't support HT well. If the BIOS has an option for you to enable/disable
> HT, then please use it. 

But since my BIOS reports 4 CPU's in the MPS table (with HT enabled), I 
guess the BIOS is doing something wrong ? Should I report this to the 
vendor ?

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

