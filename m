Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbSJRGQ3>; Fri, 18 Oct 2002 02:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264897AbSJRGQ2>; Fri, 18 Oct 2002 02:16:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37827 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264883AbSJRGQ1>;
	Fri, 18 Oct 2002 02:16:27 -0400
Date: Thu, 17 Oct 2002 23:14:54 -0700 (PDT)
Message-Id: <20021017.231454.60541659.davem@redhat.com>
To: omit@rice.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Double & Integral don't match
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <004301c27664$9d224070$7e0c2a80@OMIT>
References: <004301c27664$9d224070$7e0c2a80@OMIT>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You may not do floating point operations in the kernel.
