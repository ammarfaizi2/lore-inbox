Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVADFNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVADFNM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVADFJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:09:39 -0500
Received: from main.gmane.org ([80.91.229.2]:47821 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262045AbVADFFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 00:05:17 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: starting with 2.7
Date: Tue, 04 Jan 2005 10:06:24 +0500
Message-ID: <crd864$bkp$1@sea.gmane.org>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103123325.GV29332@holomorphy.com> <20050103213845.GA18010@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inet.ycc.ru
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

> I feel they're brave. I know several other people who went back, either
> because they didn't feel comfortable with upgrades these size, which
> sometimes did not boot because of random patches, or simply because of the
> scheduler which didn't let them type normally in an SSH session on a
> CPU-bound system, or even a proxy which performance dropped by a factor of
> 5 between 2.4 and 2.6. I know they don't report it, but they are not
> developpers. They see that 2.6 is not ready yet, and turn back to stable
> 2.4.

Here is one more regression report.

My /home was on reiserfs some time ago (migrated to ext3 using convertfs due
to this regression). I read my mail with KMail. I am also subscribed to
several mailing lists. I have a separate Maildir-formatted folder for each
mailing list. Some of such folders are more than a year old and contain
thousands of messages. With linux-2.4, I could click on such folder and the
list of messages sorted by subject will appear in KMail almost instantly.
With linux-2.6, this process takes much longer.

-- 
Alexander E. Patrakov

