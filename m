Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVAEJQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVAEJQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVAEJQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:16:58 -0500
Received: from main.gmane.org ([80.91.229.2]:51621 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262299AbVAEJM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:12:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: starting with 2.7
Date: Wed, 05 Jan 2005 14:13:27 +0500
Message-ID: <crgb15$rvq$1@sea.gmane.org>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103123325.GV29332@holomorphy.com> <20050103213845.GA18010@alpha.home.local> <crd864$bkp$1@sea.gmane.org> <20050105004202.3de71167.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 50-46.dial.utk.ru
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> "Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:
>>
>> With linux-2.4, I could click on such folder and the
>>  list of messages sorted by subject will appear in KMail almost
>>  instantly. With linux-2.6, this process takes much longer.
> 
> There was a bug in kmail which caused this.  It must have been a quite old
> version.  It can be worked around by mounting the reiserfs3 filessytem
> with
> the "nolargeio=1" mount option.  Or by upgrading kmail.

Thanks for notifying me. I have already upgraded KMail, but I am probably
too lazy to migrate back to reiserfs right now.

-- 
Alexander E. Patrakov

