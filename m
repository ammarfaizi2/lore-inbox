Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265929AbUAUMmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 07:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUAUMmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 07:42:08 -0500
Received: from ns.suse.de ([195.135.220.2]:60873 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265929AbUAUMmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 07:42:06 -0500
Date: Wed, 21 Jan 2004 13:42:04 +0100
From: Andi Kleen <ak@suse.de>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       vojtech@suse.cz
Subject: Re: mouse configuration in 2.6.1
Message-Id: <20040121134204.73e6450f.ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0401211228300.25485@student.dei.uc.pt>
References: <p73r7xwglgn.fsf@verdi.suse.de>
	<20040121043608.6E4BB2C0CB@lists.samba.org>
	<20040121132337.7f8d3c79.ak@suse.de>
	<Pine.LNX.4.58.0401211228300.25485@student.dei.uc.pt>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jan 2004 12:31:21 +0000 (WET)
"Marcos D. Marado Torres" <marado@student.dei.uc.pt> wrote:

> apparently:
> >
> > psmouse_base.psmouse_proto=bare
> 
> Actually it's psmouse.proto=bare

In 2.6.1 it is definitely psmouse_base.psmouse_proto=bare

-Andi
