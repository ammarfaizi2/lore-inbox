Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264684AbSJOXjI>; Tue, 15 Oct 2002 19:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264812AbSJOXjI>; Tue, 15 Oct 2002 19:39:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15018 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264684AbSJOXjI>;
	Tue, 15 Oct 2002 19:39:08 -0400
Date: Tue, 15 Oct 2002 16:37:49 -0700 (PDT)
Message-Id: <20021015.163749.38782953.davem@redhat.com>
To: levon@movementarian.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/7] oprofile - dcookies
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021015223255.GB41906@compsoc.man.ac.uk>
References: <20021015223255.GB41906@compsoc.man.ac.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you make the dcookie a fixed sized type such
as "u32" so we don't have headaches translating this
system call for 32-bit apps on 64-bit systems?

Much appreciated.
