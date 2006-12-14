Return-Path: <linux-kernel-owner+w=401wt.eu-S1751831AbWLNIep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWLNIep (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbWLNIep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:34:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37329 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbWLNIep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:34:45 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible to have restricted irqs
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>
	<m1lklbport.fsf@ebiederm.dsl.xmission.com>
	<20061213194332.GA29185@elte.hu>
	<m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>
	<45806137.4020403@linux.intel.com>
	<m11wn3p0zk.fsf@ebiederm.dsl.xmission.com>
	<45810383.2060708@linux.intel.com>
	<m1psamopjj.fsf@ebiederm.dsl.xmission.com>
	<458109FA.3060304@linux.intel.com>
Date: Thu, 14 Dec 2006 01:34:26 -0700
In-Reply-To: <458109FA.3060304@linux.intel.com> (Arjan van de Ven's message of
	"Thu, 14 Dec 2006 09:23:22 +0100")
Message-ID: <m1lklaooz1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

> Eric W. Biederman wrote:
>>> 1) is very real today
>>> 2) is partially real on some of the bigger numa stuff already.
>>
>> You have said you the NUMA cases is handled in another way already?
>
> the numa case of "I prefer that cpu" is handled. Not the "I cannot work on
> those".

How is the NUMA case of I prefer that cpu handled?

Eric
