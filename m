Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbVKPUii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbVKPUii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbVKPUii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:38:38 -0500
Received: from khc.piap.pl ([195.187.100.11]:26372 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030479AbVKPUih convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:38:37 -0500
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: "Wed, 16 Nov 2005 00:41:11 +0100" <grundig@teleline.es>,
       Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051116004111.45f3f704.grundig@teleline.es>
	<1132131854.1600.12.camel@tara.firmix.at>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 16 Nov 2005 21:38:30 +0100
In-Reply-To: <1132131854.1600.12.camel@tara.firmix.at> (Bernd Petrovitsch's
 message of "Wed, 16 Nov 2005 10:04:14 +0100")
Message-ID: <m3zmo48h15.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch <bernd@firmix.at> writes:

> Set the default value to "4k" and - to streß it further - remove the
> questions on `make *config` so that sufficiently interesting people must
> edit by hand after searching for it.

Haven't Red Hat tested that long enough?
-- 
Krzysztof Halasa
