Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWFGWS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWFGWS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWFGWS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:18:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:54772 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932441AbWFGWSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:18:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=laeRbbUuM8w8BbWO/dhw5Ja+11LiFWZygt4Sik9J5QA14OGR3j+E4S45c/kkBcu9j5xqcJvjaztsAGdepGKpicyOJ7H37+eUa28wNuKLdkQSfLL1wXWSWvEXjnlk1G9Q+sqncJmWSshFq4zjToPJ3YGm8vifOpHcvlNhSd/Cjyw=
Date: Thu, 8 Jun 2006 00:18:06 +0200
From: Diego Calleja <diegocg@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@vger.kernel.org,
       linux-xfs@oss.sgi.com, ecki@lina.inka.de, lkml@rtr.ca
Subject: Re: Updated sysctl documentation take #2
Message-Id: <20060608001806.028ab05a.diegocg@gmail.com>
In-Reply-To: <20060607130653.9a4d572c.rdunlap@xenotime.net>
References: <20060607205316.bbb3c379.diegocg@gmail.com>
	<20060607130653.9a4d572c.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 7 Jun 2006 13:06:53 -0700,
"Randy.Dunlap" <rdunlap@xenotime.net> escribió:


> I don't know how long it takes to review such a large patch, but
> I'll continue to do so.  For now:

Yeah, my english is poor ;)

Most of the sysctl documentation cames from other files anyway, 
README was (re)written by me, so the rest is not so bad...


> OK, that's all for the README file.  I'll look at the rest of it
> sometime this week.  I don't think that it's quite ready to be merged.


Thank's for your review, altought I didn't though someone was to review
so deeply a documentation patch ;) I've gone through all the files and
fixed the 72-col limit and everything I could. I've updated the patch
http://terra.es/personal/diegocg/sysctl-docs

