Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVL3LWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVL3LWE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 06:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVL3LWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 06:22:04 -0500
Received: from ns.firmix.at ([62.141.48.66]:29644 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751251AbVL3LWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 06:22:02 -0500
Subject: Re: [PATCH] Make sysenter support optional
From: Bernd Petrovitsch <bernd@firmix.at>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Matt Mackall <mpm@selenic.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <43B4B1AF.3020303@redhat.com>
References: <20051228212402.GX3356@waste.org>
	 <a36005b50512281407x74415958tb0fa2b52f4dd7988@mail.gmail.com>
	 <43B30E19.6080207@redhat.com> <20051229195641.GB3356@waste.org>
	 <a36005b50512291901l6a5acb77ha17d3552ea9c9fd9@mail.gmail.com>
	 <43B4A3CA.4060406@redhat.com> <20051230033803.GG3356@waste.org>
	 <43B4B1AF.3020303@redhat.com>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Fri, 30 Dec 2005 12:20:54 +0100
Message-Id: <1135941654.3342.24.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 20:03 -0800, Ulrich Drepper wrote:
> Matt Mackall wrote:
> > Ok, let me be explicit: think systems with absolutely no facility for
> > recording or displaying a backtrace.
> 
> You don't know much about unwinding, do you?  The same information is
> needed for C++ exception handling, thread cancellation, etc.  Now go on
> and tell me you don't need this either.

On (presumbly small) embedded devices?
Please be serious.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



