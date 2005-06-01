Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVFAM3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVFAM3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVFAM27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:28:59 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:20617 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261364AbVFAM1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:27:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: coywolf@lovecn.org
Subject: Re: [RFC/PATCH 0/5] add execute in place support
Date: Wed, 1 Jun 2005 14:06:03 +0200
User-Agent: KMail/1.7.2
Cc: cotte@freenet.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
References: <428216DF.8070205@de.ibm.com> <2cd57c9005060103122b2bae36@mail.gmail.com>
In-Reply-To: <2cd57c9005060103122b2bae36@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506011406.04191.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 01 Juni 2005 12:12, Coywolf Qi Hunt wrote:
> > 
> > As I'd like to aim for integration into -mm and vanilla later on,
> > I'd like to encourage everyone to give it a read and provide
> > feedback. All patches apply against git-head as of today.
> 
> I feel the name "execute in place" misleading. This is not the real
> XIP, IMHO. Invent another term or be tolerant?

If this is not real execute in place, then what is? The term seems to
describe the patch rather well and we don't have this ability for Linux
applications anywhere else, at least not in official kernels.

	Arnd <><
