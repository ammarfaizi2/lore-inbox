Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265753AbUBJKsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 05:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUBJKsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 05:48:09 -0500
Received: from rxrelay.lga.net.sg ([203.92.84.247]:57554 "HELO
	rxrelay.lga.net.sg") by vger.kernel.org with SMTP id S265753AbUBJKsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 05:48:07 -0500
Message-ID: <01C3F006.46F77B80.vanitha@agilis.st.com.sg>
From: Vanitha Ramaswami <vanitha@agilis.st.com.sg>
Reply-To: "vanitha@agilis.st.com.sg" <vanitha@agilis.st.com.sg>
To: "'redhat-ppp-list@redhat.com'" <redhat-ppp-list@redhat.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Creating Multiple bundles using MLPPP
Date: Tue, 10 Feb 2004 18:47:03 +0800
Organization: Agilis
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Is there any configuration option which allows to create
two independent multilink bundles in Linux PPP ? Though its not much of 
use in creating two multilink bundles in one linux PC, for testing
purposes i am trying to run multilink PPP sessions over pseudo-terminals.

I am able to establish one multilink PPP session over a pseudo-terminal,
and when try to establish the second multilink PPP session i am getting
an error message from pppd. "Couldn't connect to interface unit 0: Invalid Argument."

Is is possible to run multilink PPP sessions over pseudo terminals.??

Thanks,
Vanitha
