Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWG3NER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWG3NER (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWG3NER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:04:17 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:23495 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S932313AbWG3NEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:04:16 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
Date: Sun, 30 Jul 2006 16:49:57 GMT
Message-ID: <06AU6RA11@briare1.heliogroup.fr>
X-Mailer: Pliant 96
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
>
> It's not that you've set COMPAT_VDSO to n, and then don't have a recent enough 
> glibc, is it?

You must be right because FullPliant automatic kernel build system defaults
everything to false. I was not awared of the new COMPAT_VDSO.
Sorry for the noise.

