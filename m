Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWC1F15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWC1F15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 00:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWC1F15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 00:27:57 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:54412 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932196AbWC1F14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 00:27:56 -0500
Subject: Re: [Devel] Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
From: Sam Vilain <sam@vilain.net>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060327124517.GA16114@sergelap.austin.ibm.com>
References: <20060321061333.27638.63963.stgit@localhost.localdomain>
	 <1142967011.10906.185.camel@localhost.localdomain>
	 <44206B58.5000404@vilain.net>
	 <1142976756.10906.200.camel@localhost.localdomain>
	 <4420885F.5070602@vilain.net> <m1bqvzq7de.fsf@ebiederm.dsl.xmission.com>
	 <44241214.7090405@sw.ru>  <20060327124517.GA16114@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 17:28:13 +1200
Message-Id: <1143523693.7156.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 06:45 -0600, Serge E. Hallyn wrote:
> In particular, the following scenario should be perfectly valid:
> 
> 	Machine 1                    Machine 2
> 	  Xen VM1.1                    Xen VM2.1
> 	    vserv 1.1.1                  vserv2.1.1
> 	      cont1.1.1.1                  cont2.1.1.1

Precisely ... Xen and vserver are complementary, not contradictory.

Sam.

