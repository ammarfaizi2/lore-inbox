Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWCXJE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWCXJE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWCXJE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:04:57 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:47352 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751059AbWCXJEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:04:53 -0500
Date: Fri, 24 Mar 2006 10:06:11 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch 2/6] s390: qeth driver statistics fixes
Message-ID: <20060324100611.5c59e68b@localhost.localdomain>
In-Reply-To: <4421FA37.4050703@pobox.com>
References: <20060322160339.4e6cf34e@localhost.localdomain>
	<4421FA37.4050703@pobox.com>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006 20:30:31 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Frank Pavlic wrote:
> > [patch 2/6] s390: qeth driver statistics fixes 
> > 
> > From: Ursula Braun <braunu@de.ibm.com>
> > 	- display "unsigned int" values in /proc/qeth_perf with %u instead of %i
> > 	- omit qdio header length when increasing card->stats.tx_bytes
> > 
> > Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>
> 
> applied 2-4
> 
> I am OK with removing tty from network driver (patches 5-6), but they 
> didn't apply
> 
> 

hmm ok , I have built new ones today ...
Let me know if you still run into problems to apply the new two ctc tty removal patches...

Thanks 

Frank
