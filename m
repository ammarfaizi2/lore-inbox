Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270874AbTGNVeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270848AbTGNVdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:33:14 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:40597 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270849AbTGNVbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:31:14 -0400
Date: Mon, 14 Jul 2003 22:45:17 +0100
From: Jamie Lokier <jamie@shareable.org>
To: kuznet@ms2.inr.ac.ru
Cc: "David S. Miller" <davem@redhat.com>, davidel@xmailserver.org,
       e0206@foo21.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030714214517.GA29132@mail.jlokier.co.uk>
References: <20030712222457.3d132897.davem@redhat.com> <200307141709.VAA05176@dub.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307141709.VAA05176@dub.inr.ac.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> Well, "elsewhere" is mostly af_unix, half-duplex close makes sense only
> for tcp and af_unix.

What about sctp - can that do half-duplex close?

-- Jamie
