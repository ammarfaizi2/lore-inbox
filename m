Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVHaQ0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVHaQ0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVHaQ0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:26:20 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:17856 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964863AbVHaQ0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:26:19 -0400
Subject: Re: tty problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nilesh Agrawal <nilesh.agrawal@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9a9e5ab905083108503285865b@mail.gmail.com>
References: <9a9e5ab90508310806114ab96b@mail.gmail.com>
	 <4315CA02.4000802@gmail.com>  <9a9e5ab905083108503285865b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Aug 2005 17:50:10 +0100
Message-Id: <1125507010.3355.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-08-31 at 21:20 +0530, Nilesh Agrawal wrote:
> mdacon: MDA with 8K of memory detected.
> Console: switching consoles 1-16 to mono MDA-2 80x25

You've compiled in the MDA driver, probably not what you want to load on
that hardware

