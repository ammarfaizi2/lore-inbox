Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUHWN2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUHWN2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUHWN2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:28:17 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:50407 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S264213AbUHWN2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:28:16 -0400
Message-ID: <4129F0C5.3040309@ttnet.net.tr>
Date: Mon, 23 Aug 2004 16:27:33 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 2.4] gcc-3.4 more fixes
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Ozkan,
 >
 > This are just warning fixes right?
 >
 > I dont like this patches, that is, I'm not confident about them.
 >
 >  Let the warnings be.

For gcc-3.4 they're warnings. For gcc-3.5 they'll cause compiler
failures (that's what mikpe says on cset-1.1490, too)
