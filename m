Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbVJ1GzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbVJ1GzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbVJ1GzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:55:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965117AbVJ1GzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:55:19 -0400
Subject: Re: NPTL support for 2.4.31?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4361B55C.7000705@t-online.de>
References: <4361B55C.7000705@t-online.de>
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Fri, 28 Oct 2005 08:55:07 +0200
Message-Id: <1130482508.2800.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 07:21 +0200, Harald Dunkel wrote:
> Hi folks,
> 
> Is there some module/patch for kernel 2.4.31 available to
> support NPTL? I know that there is a backport in RH's 2.4.21,
> but obviously it didn't make it into the native 2.4 kernel.


you really, really, really, want and need to use 2.6 for this.
(or 2.4.21)


