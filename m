Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318641AbSH1DoR>; Tue, 27 Aug 2002 23:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318642AbSH1DoR>; Tue, 27 Aug 2002 23:44:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56724 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318641AbSH1DoQ>;
	Tue, 27 Aug 2002 23:44:16 -0400
Date: Tue, 27 Aug 2002 20:42:59 -0700 (PDT)
Message-Id: <20020827.204259.44983328.davem@redhat.com>
To: spotter@cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: tcp_hashinfo exported or not?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1030503622.487.2.camel@zaphod>
References: <1030503622.487.2.camel@zaphod>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's only exported when IPV6 is enabled as a module.
