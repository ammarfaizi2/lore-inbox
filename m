Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUHCCv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUHCCv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 22:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUHCCv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 22:51:26 -0400
Received: from main.gmane.org ([80.91.224.249]:32958 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264929AbUHCCvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 22:51:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: "Fix" broke PPP filtering
Date: Tue, 03 Aug 2004 08:51:33 +0600
Message-ID: <410EFDB5.4070405@ums.usu.ru>
References: <16654.49389.304058.800578@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsa.physics.usu.ru
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
In-Reply-To: <16654.49389.304058.800578@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> There was a changeset that went into Linus' tree on 9 April with the
> title "[ISDN]: Fix kernel PPP/IPPP active/passiv filter code",
> attributed to kkeil@suse.de.  The change to ppp_generic.c in that
> changeset means that the active-filter option in pppd no longer
> works.

Should I just revert that to make active-filter work again?

-- 
Alexander E. Patrakov

