Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWJWH6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWJWH6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWJWH6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:58:06 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:63138 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751767AbWJWH6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:58:04 -0400
Date: Mon, 23 Oct 2006 09:58:40 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.19-rc2-mm2
Message-ID: <20061023095840.051bff42@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061020102520.67b8c2ab.akpm@osdl.org>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	<200610201339.49190.m.kozlowski@tuxland.pl>
	<20061020091901.71a473e9.akpm@osdl.org>
	<200610201854.43893.m.kozlowski@tuxland.pl>
	<20061020102520.67b8c2ab.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 10:25:20 -0700,
Andrew Morton <akpm@osdl.org> wrote:

> Ow.  Multithreaded probing was probably a bt ambitious, given the current
> status of kernel startup..

IMHO, multithreaded probing as currently implemented doesn't look sane.
See http://marc.theaimsgroup.com/?l=linux-kernel&m=116108334418165&w=2
for my take on it...

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
