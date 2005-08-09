Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVHIPQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVHIPQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVHIPQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:16:28 -0400
Received: from butter.kernelcode.com ([216.254.126.222]:63503 "HELO
	butter.kernelcode.com") by vger.kernel.org with SMTP
	id S964817AbVHIPQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:16:27 -0400
Subject: Re: understanding Linux capabilities brokenness
From: Christopher Warner <cwarner@kernelcode.com>
To: James Morris <jmorris@namei.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       David Wagner <daw-usenet@taverner.CS.Berkeley.EDU>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508090044400.20178@excalibur.intercode>
References: <20050808211241.GA22446@clipper.ens.fr>
	 <20050808223238.GA523@clipper.ens.fr>
	 <dd8r9s$eqn$1@taverner.CS.Berkeley.EDU> <20050809015048.GA14204@thunk.org>
	 <Pine.LNX.4.63.0508090044400.20178@excalibur.intercode>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 11:16:33 -0400
Message-Id: <1123600593.7622.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my observer pragmatic view; yes. On many occasion, i've come to CAP
calls only to be frustrated with the sheer disconnect of it all. It
simply doesn't work. If it means having to break posix conformance for a
working implementation. Then so be it.

-- Christopher Warner

On Tue, 2005-08-09 at 00:46 -0400, James Morris wrote:
> Let me play the Devil's advocate here.
> 
> Should we be thinking about deprecating and removing capabilities from 
> Linux?
> 
> 
> - James

