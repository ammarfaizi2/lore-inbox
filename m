Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVFOUDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVFOUDI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVFOUDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:03:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55175 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261533AbVFOUDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:03:05 -0400
Date: Wed, 15 Jun 2005 16:02:52 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Reiner Sailer <sailer@watson.ibm.com>
cc: LKML <linux-kernel@vger.kernel.org>, LSM <linux-security-module@wirex.com>,
       Tom Lendacky <toml@us.ibm.com>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, Emily Rattlif <emilyr@us.ibm.com>,
       Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
In-Reply-To: <1118846413.2269.18.camel@secureip.watson.ibm.com>
Message-ID: <Xine.LNX.4.44.0506151601310.27162-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, Reiner Sailer wrote:

> This patch applies against linux-2.6.12-rc6-mm1 and provides the main
> Integrity Measurement Architecture code (LSM-based).

Why are you still trying to use LSM for this?

Last time, there was discussion on the issue, ending here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111665641301726&w=2


- James
-- 
James Morris
<jmorris@redhat.com>


