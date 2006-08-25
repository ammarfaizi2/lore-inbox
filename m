Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422849AbWHYWOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422849AbWHYWOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 18:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422851AbWHYWOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 18:14:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422849AbWHYWOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 18:14:45 -0400
Date: Fri, 25 Aug 2006 15:14:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, mingo@elte.hu,
       jbarnes@virtuousgeek.org, dwalker@mvista.com, nickpiggin@yahoo.com.au
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
Message-Id: <20060825151434.6bd75ae2.akpm@osdl.org>
In-Reply-To: <1156504939.3032.26.camel@laptopd505.fenrus.org>
References: <1156504939.3032.26.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 13:22:19 +0200
Arjan van de Ven <arjan@linux.intel.com> wrote:

> One open question is if the sysreq key is considered useful or only a bad hack..

The latter ;)
