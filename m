Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUGHNwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUGHNwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUGHNwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:52:31 -0400
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:10962 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S264881AbUGHNwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:52:30 -0400
Date: Thu, 8 Jul 2004 15:52:29 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Willy Weisz <weisz@vcpc.univie.ac.at>
Cc: Michael Buesch <mbuesch@freenet.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kaya <kaya@emailkaya.com>
Subject: Re: APIC error on CPU0:60(60)
Message-ID: <20040708135229.GB22156@boogie.lpds.sztaki.hu>
References: <40EBFAF7.1080505@vcpc.univie.ac.at> <200407071914.44496.mbuesch@freenet.de> <20040708115849.GA32540@boogie.lpds.sztaki.hu> <40ED4E51.10904@vcpc.univie.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ED4E51.10904@vcpc.univie.ac.at>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 03:38:25PM +0200, Willy Weisz wrote:

> The problem only arises in one of our servers, the only one
> with an Intel E7505 chipset. Is this related or pure coincidence?

My machine showing the problem has an Abit TH7II-Raid board with the
Intel 850 chipset.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences,
     Laboratory of Parallel and Distributed Systems
     Address   : H-1132 Budapest Victor Hugo u. 18-22. Hungary
     Phone/Fax : +36 1 329-78-64 (secretary)
     W3        : http://www.lpds.sztaki.hu
     ---------------------------------------------------------
