Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137069AbREKX6R>; Fri, 11 May 2001 19:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143422AbREKX55>; Fri, 11 May 2001 19:57:57 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:19975 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S137069AbREKX5v>;
	Fri, 11 May 2001 19:57:51 -0400
Date: Fri, 11 May 2001 16:57:49 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk
Subject: 2.4.4-ac8 doesn't work with Lite-On 82c168 PNIC rev 32
Message-ID: <20010511165749.B12289@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The tulip driver in 2.4.4-ac8 doesn't work with Lite-On 82c168 PNIC
rev 32 in the NetGear FA310TX REV-D2. It sends BOOTP request and
times out.


H.J.
