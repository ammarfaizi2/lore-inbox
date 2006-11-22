Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757034AbWKVVcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757034AbWKVVcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757036AbWKVVcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:32:07 -0500
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:4273 "EHLO
	mail.lidskialf.net") by vger.kernel.org with ESMTP id S1757034AbWKVVcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:32:06 -0500
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: v4l-dvb-maintainer@linuxtv.org
Subject: Re: [v4l-dvb-maintainer] Re: [Devel] Re: [PATCH/RFC] kthread API conversion for dvb_frontend =?iso-8859-1?q?and=09av7110?=
Date: Wed, 22 Nov 2006 21:32:03 +0000
User-Agent: KMail/1.9.4
Cc: Cedric Le Goater <clg@fr.ibm.com>, devel@openvz.org,
       containers@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Herbert Poetzl <herbert@13thfloor.at>
References: <45019CC3.2030709@fr.ibm.com> <200611170150.02207.adq_dvb@lidskialf.net> <45646512.7070806@fr.ibm.com>
In-Reply-To: <45646512.7070806@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611222132.04373.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 November 2006 14:56, Cedric Le Goater wrote:
> Andrew de Quincey wrote:
> > Hi - the conversion looks good to me.. I can't really offer any more
> > constructive suggestions beyond what Cedric has already said.
>
> ok. so, should we just resend a refreshed version of the patch when 2.6.19
> comes out ?

Yeah - sounds good.

> > Theres another thread in dvb_ca_en50221.c that could be converted as well
> > though, hint hint ;)
>
> ok ok :) i'll look at it ...

heh :)
