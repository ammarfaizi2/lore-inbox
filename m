Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWDTPwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWDTPwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWDTPwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:52:04 -0400
Received: from iona.labri.fr ([147.210.8.143]:11166 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1751046AbWDTPwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:52:03 -0400
Message-ID: <4447AD52.60402@labri.fr>
Date: Thu, 20 Apr 2006 17:48:34 +0200
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [libata] atapi_enabled problem
References: <44477D93.50501@labri.fr> <20060420082852.f679a376.rdunlap@xenotime.net>
In-Reply-To: <20060420082852.f679a376.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy.

Randy.Dunlap wrote:
> 
> Yes, it should and it has worked for quite a few people in the past.
> I suspect something more like a typo.  Anyway, recent kernels
> (after 2.6.16, so 2.6.17-rc*) already have atapi_enabled set to 1.

My mistake, I forgot to say I was using 2.6.16.2. Maybe this
atapi_enabled=1 does appear only in 2.6.17-rc* ?

Anyway, setting atapi_enabled to '1' in the future releases should solve
my problem. So, I guess that this isn't a bug after all (just a
difficult transition :).

Thanks to all
-- 
Emmanuel Fleury              | Office: 211
Associate Professor,         | Phone: +33 (0)5 40 00 35 24
LaBRI, Domaine Universitaire | Fax:   +33 (0)5 40 00 66 69
351, Cours de la Libération  | email: emmanuel.fleury@labri.fr
33405 Talence Cedex, France  | URL: http://www.labri.fr/~fleury
