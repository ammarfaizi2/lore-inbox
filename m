Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbSKOVKT>; Fri, 15 Nov 2002 16:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbSKOVKT>; Fri, 15 Nov 2002 16:10:19 -0500
Received: from rth.ninka.net ([216.101.162.244]:35735 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S266730AbSKOVKS>;
	Fri, 15 Nov 2002 16:10:18 -0500
Subject: Re: TCPPureAcks TCPHPAcks - Definition?
From: "David S. Miller" <davem@redhat.com>
To: Arcot Arumugam <arcot_arumugam@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <DAV35iMCIqtQvAauNjV00005dc0@hotmail.com>
References: <DAV35iMCIqtQvAauNjV00005dc0@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 13:35:51 -0800
Message-Id: <1037396151.22279.5.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 13:03, Arcot Arumugam wrote:
> Does anyone know about what these fields contain? Is it documented anywhere?

They are statistics for the developers of the networking
stack, if you can't be bothered to read and unstand the
places in the TCP stack sources where these counters are
bumped then congratulations these statistics can safely
be ignored by you :-)

