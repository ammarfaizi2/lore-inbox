Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272932AbTG3QH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272937AbTG3QH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:07:28 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:12184 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272932AbTG3QHV (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:07:21 -0400
Date: Wed, 30 Jul 2003 18:04:03 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: John Bradford <john@grabjohn.com>, Riley@Williams.Name,
       Linux-Kernel@vger.kernel.org
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Message-ID: <20030730160403.GF12849@louise.pinerecords.com>
References: <200307300911.h6U9BH2f000813@81-2-122-30.bradfords.org.uk> <20030730104421.GC28767@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730104421.GC28767@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [bunk@fs.tum.de]
> 
> If a _user_ of a stable kernel notices "it doesn't even compile" this 
> gives a very bad impression of the quality of the Linux kernel.

The keyword in this sentence is "stable."
Could you maybe come up with this again at around 2.6.40? :)

-- 
Tomas Szepe <szepe@pinerecords.com>
