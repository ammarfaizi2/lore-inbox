Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754416AbWKVO4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbWKVO4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754411AbWKVO4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:56:24 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:734 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1754009AbWKVO4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:56:23 -0500
Message-ID: <45646512.7070806@fr.ibm.com>
Date: Wed, 22 Nov 2006 15:56:18 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: devel@openvz.org
CC: Herbert Poetzl <herbert@13thfloor.at>, containers@lists.osdl.org,
       v4l-dvb-maintainer@linuxtv.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Devel] Re: [PATCH/RFC] kthread API conversion for dvb_frontend
 and	av7110
References: <45019CC3.2030709@fr.ibm.com> <4509C4A5.5030600@fr.ibm.com>	<20060914221024.GB26916@MAIL.13thfloor.at> <200611170150.02207.adq_dvb@lidskialf.net>
In-Reply-To: <200611170150.02207.adq_dvb@lidskialf.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey wrote:

> Hi - the conversion looks good to me.. I can't really offer any more 
> constructive suggestions beyond what Cedric has already said. 

ok. so, should we just resend a refreshed version of the patch when 2.6.19
comes out ?  

> Theres another thread in dvb_ca_en50221.c that could be converted as well 
> though, hint hint ;)

ok ok :) i'll look at it ...
 
> Apologies for the delay in this reply - I've been hibernating for a bit.

np.

thanks,

C.
