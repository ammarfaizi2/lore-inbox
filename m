Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261566AbSJHXlE>; Tue, 8 Oct 2002 19:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSJHXlD>; Tue, 8 Oct 2002 19:41:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8105 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261566AbSJHXk5>;
	Tue, 8 Oct 2002 19:40:57 -0400
Date: Tue, 08 Oct 2002 16:39:35 -0700 (PDT)
Message-Id: <20021008.163935.115225472.davem@redhat.com>
To: bidulock@openss7.org
Cc: linux-kernel@vger.kernel.org, linux-streams@gsyc.escet.urjc.es
Subject: Re: [PATCH] Re: export of sys_call_table
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021008162733.B11638@openss7.org>
References: <20021004.153804.94857396.davem@redhat.com>
	<20021008162017.A11261@openss7.org>
	<20021008162733.B11638@openss7.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1) How can anyone test this, the new syscall entries point
   to nothing so the final kernel image won't even link.

2) Did you even check if the SunOS and Linux streams system
   calls take the same arguments?
