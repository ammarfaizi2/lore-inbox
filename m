Return-Path: <linux-kernel-owner+w=401wt.eu-S1425615AbWLHQmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425615AbWLHQmI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425616AbWLHQmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:42:08 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:44940 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425615AbWLHQmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:42:07 -0500
Date: Fri, 8 Dec 2006 17:42:06 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061208164206.GA1125@torres.l21.ma.zugschlus.de>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> <4578465D.7030104@cfl.rr.com> <1165541892.1063.0.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1165541892.1063.0.camel@sebastian.intellilink.co.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 10:38:12AM +0900, Fernando Luis Vázquez Cao wrote:
> Does the patch below help?
> 
> http://marc.theaimsgroup.com/?l=linux-ext4&m=116483980823714&w=4

No, pkgcache.bin still getting corrupted within two hours of using
2.6.19.

Greetings
Marc, back to 2.6.18.3 for the time being

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
