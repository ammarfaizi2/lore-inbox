Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbRCZRKN>; Mon, 26 Mar 2001 12:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRCZRKD>; Mon, 26 Mar 2001 12:10:03 -0500
Received: from jalon.able.es ([212.97.163.2]:8112 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132491AbRCZRJr>;
	Mon, 26 Mar 2001 12:09:47 -0500
Date: Mon, 26 Mar 2001 19:08:58 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "Hen, Shmulik" <shmulik.hen@intel.com>
Cc: "'Leonid Mamtchenkov'" <leonid@francoudi.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: Q: How do I get from the latest stable kernel version to the latest prepatch version ?
Message-ID: <20010326190858.A1189@werewolf.able.es>
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27197@hasmsx52.iil.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27197@hasmsx52.iil.intel.com>; from shmulik.hen@intel.com on Mon, Mar 26, 2001 at 16:14:06 +0200
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.26 "Hen, Shmulik" wrote:
> Thanks.
> It just struck me odd that the latest is 2.4.2 while the prepatches were
> 2.4.3 so I figured there must be something I missed in between (my logic
> told me that a 2.4.3 patch would be against a 2.4.3 something ;-).
> 

It all depends on the name of the patch. Usually, the '-preXX' patches
are 'previews' of the thing, so a 2.4.3-pre8 is 'preview 8 of what could
be 2.4.3', so as 2.4.3 still does not exist, the patch applies on 2.4.2.

On the other way, the Alan Cox series  is named 2.4.2-acXX, because they
add features to test to 2.4.2 that anybody knows if will end on an 'official'
kernel. Perhaps if a bugfix-feature that appears in 2.4.2-acX is ok, it
can end up in the official preview 2.4.3-preY for the next kernel.
 
-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac24 #1 SMP Sat Mar 24 12:40:29 CET 2001 i686

