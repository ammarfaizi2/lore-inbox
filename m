Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290508AbSAQWfY>; Thu, 17 Jan 2002 17:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290506AbSAQWfQ>; Thu, 17 Jan 2002 17:35:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49292 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290502AbSAQWfB>;
	Thu, 17 Jan 2002 17:35:01 -0500
Date: Thu, 17 Jan 2002 14:33:15 -0800 (PST)
Message-Id: <20020117.143315.85394543.davem@redhat.com>
To: mark@somanetworks.com
Cc: ak@muc.de, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] new sysctl net/ipv4/ip_default_bind
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020117172713.A1893@somanetworks.com>
In-Reply-To: <20020117172713.A1893@somanetworks.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you setup your routes properly, one will be marked "primary"
and will be used for outgoing address selection.
