Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263201AbTCYSpZ>; Tue, 25 Mar 2003 13:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263213AbTCYSpZ>; Tue, 25 Mar 2003 13:45:25 -0500
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:17306
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S263201AbTCYSpX>; Tue, 25 Mar 2003 13:45:23 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: usenet@hensema.net
cc: linux-kernel@vger.kernel.org
Message-ID: <80256CF4.0067B530.00@notesmta.eur.3com.com>
Date: Tue, 25 Mar 2003 18:52:37 +0000
Subject: Re: Negative dynamic priorities in 2.5.6[4-6]?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> top from procps-2.0.11 treats PRI as an unsigned long long

Known problem with top, for fix see
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=85423

     Jon


