Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264727AbSKDQae>; Mon, 4 Nov 2002 11:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264736AbSKDQae>; Mon, 4 Nov 2002 11:30:34 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:55184 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264727AbSKDQad>; Mon, 4 Nov 2002 11:30:33 -0500
Subject: Re: [lkcd-general] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard J Moore <richardj_moore@uk.ibm.com>,
       Oliver Xymoron <oxymoron@waste.org>,
       Dave Anderson <anderson@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net, lkcd-general@lists.sourceforge.net,
       lkcd-general-admin@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Matt D. Robinson" <yakker@aparity.com>
In-Reply-To: <Pine.LNX.4.44.0211040727330.771-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211040727330.771-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 16:57:15 +0000
Message-Id: <1036429035.1718.99.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me ask another question here

Other than "register_reboot_notifier()" and adding a 
"register_exception_notifier()" chain what else does a dump tool need.
Register_exception_notifier seems to solve about 90% of the insmod gdb 
problem space as well ?




