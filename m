Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132734AbRDQQDM>; Tue, 17 Apr 2001 12:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132736AbRDQQDC>; Tue, 17 Apr 2001 12:03:02 -0400
Received: from www.topmail.de ([212.255.16.226]:41414 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S132734AbRDQQCo>;
	Tue, 17 Apr 2001 12:02:44 -0400
From: Thorsten Glaser Geuer <eccesys@topmail.de>
Organisation: eccesys.net Linux development; adLANtix.net Routers
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: Re: generic rwsem
Message-Id: <20010417160027.26042A5A954@www.topmail.de>
Date: Tue, 17 Apr 2001 18:00:27 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot, andrea,
this patch (I only applied the rwsem one) finally fixes
the rwsem compile problem with gcc-3.0-20010417.
Now I can get a working kernel ;-)

-mirabilos
