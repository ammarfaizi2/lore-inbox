Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUCaSc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUCaSc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:32:57 -0500
Received: from mail.shareable.org ([81.29.64.88]:43412 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262316AbUCaSc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:32:56 -0500
Date: Wed, 31 Mar 2004 19:32:43 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dirk Morris <dmorris@metavize.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.2] Badness in futex_wait revisited
Message-ID: <20040331183243.GA20418@mail.shareable.org>
References: <40311703.8070309@metavize.com> <20040217051911.6AC112C066@lists.samba.org> <20040331165656.GG19280@mail.shareable.org> <406B0219.3000309@metavize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406B0219.3000309@metavize.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Morris wrote:
> Let me know if you need any further information, I can reproduce it 
> consistently.

If you have a small test program (or pair of programs) that
consistently triggers this message on any machine running 2.6.4, that
would be very helpful indeed.

-- Jamie
