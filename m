Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVHLBNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVHLBNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 21:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVHLBNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 21:13:30 -0400
Received: from terminus.zytor.com ([209.128.68.124]:9898 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932350AbVHLBNa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 21:13:30 -0400
Message-ID: <42FBF775.7070200@zytor.com>
Date: Thu, 11 Aug 2005 18:12:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Tim Yamin <plasmaroo@gentoo.org>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 5/8] Check input buffer size in zisofs
References: <20050811225445.404816000@localhost.localdomain> <20050811225633.103369000@localhost.localdomain>
In-Reply-To: <20050811225633.103369000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> -stable review patch.  If anyone has any  objections, please let us know.

Looks good to me.  Feel free to add:

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
