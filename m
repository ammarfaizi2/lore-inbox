Return-Path: <linux-kernel-owner+w=401wt.eu-S932986AbWL0PvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986AbWL0PvH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWL0PvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:51:07 -0500
Received: from web32607.mail.mud.yahoo.com ([68.142.207.234]:42029 "HELO
	web32607.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932986AbWL0PvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:51:06 -0500
Message-ID: <20061227155104.91856.qmail@web32607.mail.mud.yahoo.com>
X-YMail-OSG: J0nhGcgVM1nmoth4LO_KZTmxanY2vqQpfwD8_bhFZGxystcrDTuKrsFU_gOpQcviTwZOpRZJIdAN2bAWcE_CKqcrZJujula5vyLe5lof8o9AxxirwdK.
X-RocketYMMF: knobi.rm
Date: Wed, 27 Dec 2006 07:51:04 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and 2.6.x kernels
To: Gleb Natapov <glebn@voltaire.com>, Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061227152240.GC10953@minantech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Gleb Natapov <glebn@voltaire.com> wrote:

> > 
> If I run two threads that are doing only calculations and very little
> or no
> IO at all on the same socket will modern HT and dual core be the same
> (or close) performance wise?
> 

 actually I wanted to write that "HT as implemented on XEONs did not
help a lot for HPC workloads in the past"....

Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
