Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271700AbTGRFV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 01:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271703AbTGRFV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 01:21:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19433 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271700AbTGRFVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 01:21:55 -0400
Date: Thu, 17 Jul 2003 22:26:51 -0700
From: "David S. Miller" <davem@redhat.com>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
Message-Id: <20030717222651.2747a93e.davem@redhat.com>
In-Reply-To: <m3isq0d0wi.fsf@lugabout.jhcloos.org>
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	<3F16C190.3080205@pobox.com>
	<200307171756.19826.schlicht@uni-mannheim.de>
	<3F16C83A.2010303@pobox.com>
	<20030717125942.7fab1141.davem@redhat.com>
	<1058477803.754.11.camel@ezquiel.nara.homeip.net>
	<20030717144031.3bbacee5.davem@redhat.com>
	<m3isq0d0wi.fsf@lugabout.jhcloos.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jul 2003 22:27:57 -0400
"James H. Cloos Jr." <cloos@jhcloos.com> wrote:

> >>>>> "David" == David S Miller <davem@redhat.com> writes:
> 
> David> Are you using ipv6? 
> 
> Yes, compiled in.

I really think this is the issue, try to eliminate
it from your environment to verify.
