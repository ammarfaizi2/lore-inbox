Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWF1TyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWF1TyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWF1TyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:54:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:52163 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751148AbWF1TyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:54:08 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] x86_64: Move export symbols to their C functions
Date: Wed, 28 Jun 2006 21:52:20 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200606261902.k5QJ2R93008443@hera.kernel.org> <20060628193841.GA22587@redhat.com>
In-Reply-To: <20060628193841.GA22587@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606282152.20698.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> These two exports were never re-added, which broke modular oprofile.

Everybody and their dog sent patches for that by now and I assume
Linus already merged Andrew's version

-Andi
