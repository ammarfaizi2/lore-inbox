Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424750AbWKQBuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424750AbWKQBuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424903AbWKQBuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:50:08 -0500
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:36032 "EHLO
	mail.lidskialf.net") by vger.kernel.org with ESMTP id S1424750AbWKQBuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:50:07 -0500
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [PATCH/RFC] kthread API conversion for dvb_frontend and av7110
Date: Fri, 17 Nov 2006 01:50:01 +0000
User-Agent: KMail/1.9.4
Cc: Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, containers@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       v4l-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>
References: <45019CC3.2030709@fr.ibm.com> <4509C4A5.5030600@fr.ibm.com> <20060914221024.GB26916@MAIL.13thfloor.at>
In-Reply-To: <20060914221024.GB26916@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611170150.02207.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

> correct, will fix that up in the next round
>
> thanks for the feedback,
> Herbert

Hi - the conversion looks good to me.. I can't really offer any more 
constructive suggestions beyond what Cedric has already said. 

Theres another thread in dvb_ca_en50221.c that could be converted as well 
though, hint hint ;)

Apologies for the delay in this reply - I've been hibernating for a bit.
