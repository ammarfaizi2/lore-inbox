Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293007AbSCDXbX>; Mon, 4 Mar 2002 18:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293012AbSCDXbO>; Mon, 4 Mar 2002 18:31:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56463 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293007AbSCDXaz>;
	Mon, 4 Mar 2002 18:30:55 -0500
Date: Mon, 04 Mar 2002 15:28:32 -0800 (PST)
Message-Id: <20020304.152832.15590305.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: sungem card fails to find it's mac address
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015277575.1961.12.camel@monkey>
In-Reply-To: <1015277575.1961.12.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have to set the MAC address by hand, we can only get the ethernet
address out of the card's firmware on sparc systems currently.
