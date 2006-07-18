Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWGRFpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWGRFpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 01:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWGRFpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 01:45:05 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:36792 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S1751259AbWGRFpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 01:45:04 -0400
Message-ID: <44BC7556.4000509@stanford.edu>
Date: Mon, 17 Jul 2006 22:44:54 -0700
From: Thomas Dillig <tdillig@stanford.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: kernel_org@digitalpeer.com, linux-kernel@vger.kernel.org, eteo@redhat.com
Subject: Re: Null dereference errors in the kernel
References: <44BC5A3F.2080005@stanford.edu> <44BC6B6B.8020509@digitalpeer.com>
In-Reply-To: <44BC6B6B.8020509@digitalpeer.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joshua Henderson wrote:
> Looked at the first 4.  These are valid errors.  Seems like a rather 
> intelligent tool.  When will this tool be publicly available?

We are currently aiming for a public release of the SATURN tool some 
time in fall this year. Other students are also working on different 
types of analyses/verification modules, which will slowly become ready 
if everything goes as planned.



Eugene Teo wrote:
> I would be interested. Can you email bug reports so that bugs can be 
> fixed?
> Also, please email security@kernel.org so that they can verify the reports
> should there be any false negatives.
Also, we will ready (e.g. double-check and pretty-print) more reports 
and mail them (CC'ed to security@kernel.org) in chunks as soon as they 
are ready. Please let us know if there is anything else you want us to do.

Thanks a lot, it's exciting to hear back from developers after working 
on this for a long time :)
-Isil & Tom

