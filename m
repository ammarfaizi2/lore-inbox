Return-Path: <linux-kernel-owner+w=401wt.eu-S1750861AbWLLBuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWLLBuJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWLLBuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:50:09 -0500
Received: from gw.goop.org ([64.81.55.164]:43191 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbWLLBuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:50:07 -0500
Message-ID: <457E0AAE.7080509@goop.org>
Date: Mon, 11 Dec 2006 17:49:34 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Andi Kleen <ak@suse.de>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
References: <457E0460.4030107@goop.org> <457E08FE.6050600@vmware.com> <457E097C.5030208@goop.org> <457E0A03.3020704@vmware.com>
In-Reply-To: <457E0A03.3020704@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> It's not for us or Xen.  Perhaps it came from lhype?  

(I suspect it came from Andi's fevered brain.)  If lhype can't deal with
vdso, it can turn it off for itself - but I don't think its a problem
for lhype.

    J
