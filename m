Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTIOV41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTIOV40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:56:26 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:52868 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261620AbTIOV40 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:56:26 -0400
Date: Mon, 15 Sep 2003 23:56:21 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: "David S. Miller" <davem@redhat.com>
cc: mroos@linux.ee, <linux-kernel@vger.kernel.org>
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <20030915143813.2011187f.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0309152350190.24675-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Sep 2003, David S. Miller wrote:

> And you broke one of the primary users of the atyfb driver,
> the sparc64 platform.
>
> We don't even get a console if this driver is non-functional,
> that's the part you don't understand.  On x86 one can at least
> use the VGA or Vesa drivers, we simply don't have that option.

Yes, I understand that. It is fixed, which I did within hours after
receiving relevant info from Melis Roos. Please be a bit more friendly, ok?

Greetings

Daniël

