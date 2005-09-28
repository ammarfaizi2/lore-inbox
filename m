Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVI1P4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVI1P4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVI1P4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:56:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52978 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751079AbVI1P4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:56:35 -0400
Subject: Re: [PATCH] RT: epca_lock to DEFINE_SPINLOCK
From: Daniel Walker <dwalker@mvista.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <1127900349.2893.19.camel@laptopd505.fenrus.org>
References: <1127845928.4004.24.camel@dhcp153.mvista.com>
	 <1127900349.2893.19.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 08:54:32 -0700
Message-Id: <1127922873.8520.23.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 11:39 +0200, Arjan van de Ven wrote:

> this is really ugly though; at minimum a DEFINE_STATIC_SPINLOCK() would
> be needed to make this less ugly.


Doesn't exists as far as I know .. Shall we make one ?

Daniel 

