Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311310AbSCLSVM>; Tue, 12 Mar 2002 13:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311312AbSCLSUw>; Tue, 12 Mar 2002 13:20:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8141 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311310AbSCLSUq>;
	Tue, 12 Mar 2002 13:20:46 -0500
Date: Tue, 12 Mar 2002 10:17:13 -0800 (PST)
Message-Id: <20020312.101713.106542707.davem@redhat.com>
To: tadams-lists@myrealbox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ns83820 0.17
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015956757.4220.3.camel@aurora>
In-Reply-To: <51A3E836-35A8-11D6-A4A8-000393843900@metaparadigm.com>
	<20020312.031509.53067416.davem@redhat.com>
	<1015956757.4220.3.camel@aurora>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Trever L. Adams" <tadams-lists@myrealbox.com>
   Date: 12 Mar 2002 13:12:32 -0500
   
   David, you believe we don't need NAPI.

I said we don't need NAPI for just bandwidth streams, you mention
routing which is specifically the case I mention that NAPI is good for
(high packet rates).
