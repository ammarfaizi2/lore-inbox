Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269018AbUI3GvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269018AbUI3GvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 02:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUI3GvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 02:51:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269018AbUI3GvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 02:51:02 -0400
Date: Thu, 30 Sep 2004 02:50:37 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: "Theodore Ts'o" <tytso@mit.edu>, <linux@horizon.com>,
       <linux-kernel@vger.kernel.org>, <cryptoapi@lists.logix.cz>
Subject: Re: [PROPOSAL/PATCH 2] Fortuna PRNG in /dev/random
In-Reply-To: <20040930042303.GS16057@certainkey.com>
Message-ID: <Xine.LNX.4.44.0409300248540.3029-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2004, Jean-Luc Cooke wrote:

> This should be the last one for a while.
> 
> v2.1.4 crypto/random-fortuna.c
> 
> Ted, since this is a crypto-API feature as well as an optional replacement to
> /dev/random, should I be passing this threw James or both of you?

Whatever the case, I would follow Ted's advice on this code.


- James
-- 
James Morris
<jmorris@redhat.com>


