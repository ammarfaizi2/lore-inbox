Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280759AbRKGDxT>; Tue, 6 Nov 2001 22:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280756AbRKGDxJ>; Tue, 6 Nov 2001 22:53:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41857 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280761AbRKGDxH>;
	Tue, 6 Nov 2001 22:53:07 -0500
Date: Tue, 06 Nov 2001 19:52:57 -0800 (PST)
Message-Id: <20011106.195257.102576616.davem@redhat.com>
To: carlo@alinoe.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ircu-development] Slow on high-MTU (local host) connections?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011107043425.A15045@alinoe.com>
In-Reply-To: <20011107043425.A15045@alinoe.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Repeat your experiment with nagle disabled on the sockets
in question.

Franks a lot,
David S. Miller
davem@redhat.com
