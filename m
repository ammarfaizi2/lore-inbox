Return-Path: <linux-kernel-owner+w=401wt.eu-S1161158AbWLUDBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWLUDBJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWLUDBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:01:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:49602 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161158AbWLUDBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:01:07 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17801.57293.790405.25052@gargle.gargle.HOWL>
Date: Wed, 20 Dec 2006 19:13:49 -0600
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, David Wilder <dwilder@us.ibm.com>,
       Tom Zanussi <zanussi@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Relay CPU Hotplug support
In-Reply-To: <20061221003101.GA28643@Krystal>
References: <20061221003101.GA28643@Krystal>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers writes:
 > Hi,
 > 
 > Here is a patch, result of the combined work of Tom Zanussi and myself, to add
 > CPU hotplug support to Relay.
 > 
 > This patch applies on 2.6.20-rc1-git7.
 > 
 > Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
 > 

Hi Mathieu,

It looks like you forgot to include the Documentation update with
this.  Other than that, it looks fine to me.

Acked-by: Tom Zanussi <zanussi@us.ibm.com>


