Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbVINEWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbVINEWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 00:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVINEWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 00:22:22 -0400
Received: from xenotime.net ([66.160.160.81]:6820 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932585AbVINEWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 00:22:22 -0400
Date: Tue, 13 Sep 2005 21:22:18 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, paolo.ciarrocchi@gmail.com,
       paultt@bilug.linux.it, jesper.juhl@gmail.com, cp@absolutedigital.net
Subject: Re: [PATCH] 2.6.13-mm3 ort v.b6 (OOPS Reporting Tool), try2
Message-Id: <20050913212218.3fe77b0e.rdunlap@xenotime.net>
In-Reply-To: <43276366.80304@gmail.com>
References: <43276366.80304@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005 01:40:22 +0200 Michal Piotrowski wrote:

> Hi Andrew,
> I think, that this maybe useful for oops hunters :)
> 
> Paolo, Paul, Randy, Jesper, Cal please sign it.
> 
> Regards,
> Michal Piotrowski
> 
> Signed-off-by: Michal K. K. Piotrowski <michal.k.k.piotrowski@gmail.com>

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>


> diff -uprN -X linux-mm-clean/Documentation/dontdiff 
> linux-mm-clean/scripts/ort.sh linux-mm/scripts/ort.sh
> --- linux-mm-clean/scripts/ort.sh    1970-01-01 01:00:00.000000000 +0100
> +++ linux-mm/scripts/ort.sh    2005-09-14 01:21:01.000000000 +0200


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
