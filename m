Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWH2LQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWH2LQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWH2LQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:16:24 -0400
Received: from cantor2.suse.de ([195.135.220.15]:57230 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964892AbWH2LQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:16:23 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Tue, 29 Aug 2006 13:16:22 +0200
User-Agent: KMail/1.9.3
Cc: petkov@math.uni-muenster.de, "J. Bruce Fields" <bfields@fieldses.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060820013121.GA18401@fieldses.org> <20060829110109.GA10944@gollum.tnic> <44F43C67.76E4.0078.0@novell.com>
In-Reply-To: <44F43C67.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608291316.22327.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Without a hex dump of stack contents there's very little I can do.

Borislav, if you can reproduce the crash please boot with kstack=2048 and send output
of that.

-Andi
