Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbSKLJ0i>; Tue, 12 Nov 2002 04:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbSKLJ0i>; Tue, 12 Nov 2002 04:26:38 -0500
Received: from server0027.freedom2surf.net ([194.106.33.36]:24803 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S266367AbSKLJ0h>; Tue, 12 Nov 2002 04:26:37 -0500
Date: Tue, 12 Nov 2002 09:32:59 +0000
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Subject: devfs
Message-Id: <20021112093259.3d770f6e.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Nov 2002 20:50:39 -0500
Robert Love <rml@tech9.net> wrote:

> On Mon, 2002-11-11 at 20:32, Ryan Anderson wrote:
> 
> > From an outsider point of view (and because nobody else responded),
> > I think the big question here would be: Would you use it after this
> > cleanup?
> > 
> > If you say yes, I'd say that's a good sign in its favor.
> 
> Good heuristic, except Al would not use devfs in either case :)

Personally I love devfs. I've not looked at its internals, but its never
failed me yet, and I like the way /dev only contains stuff that actually
exists.

And if Al doesnt like the code... hes free to reimplement it...
