Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269224AbUIHXgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269224AbUIHXgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUIHXd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:33:59 -0400
Received: from the-village.bc.nu ([81.2.110.252]:10921 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269212AbUIHXdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:33:31 -0400
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Diego Calleja <diegocg@teleline.es>, Rik van Riel <riel@redhat.com>,
       raybry@sgi.com, marcelo.tosatti@cyclades.com, kernel@kolivas.org,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, piggin@cyberone.com.au
In-Reply-To: <36100000.1094677832@flay>
References: <5860000.1094664673@flay>
	 <Pine.LNX.4.44.0409081403500.23362-100000@chimarrao.boston.redhat.com>
	 <20040908215008.10a56e2b.diegocg@teleline.es>  <36100000.1094677832@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094682510.12371.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 23:28:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 22:10, Martin J. Bligh wrote:
> I really don't see any point in pushing the self-tuning of the kernel out
> into userspace. What are you hoping to achieve?

What if there is more than one right answer to "self-tune" policy. Also
what if you want an application to tweak the tuning in ways that are
different to general policy ?

